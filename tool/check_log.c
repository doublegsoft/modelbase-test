#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LINE_LENGTH 4096

typedef enum {
  LANG_UNKNOWN,
  LANG_JAVA,
  LANG_C
} Language;

/**
 * 跨平台大小写不敏感子串查找
 */
const char* str_case_str(const char* haystack, const char* needle) {
  if (!*needle) {
    return haystack;
  }
  for (; *haystack; haystack++) {
    if (tolower((unsigned char)*haystack) == tolower((unsigned char)*needle)) {
      const char* h = haystack;
      const char* n = needle;
      while (*h && *n && tolower((unsigned char)*h) == tolower((unsigned char)*n)) {
        h++;
        n++;
      }
      if (!*n) {
        return haystack;
      }
    }
  }
  return NULL;
}

/**
 * 跨平台大小写不敏感字符串比较
 */
int str_case_cmp(const char* s1, const char* s2) {
  while (*s1 && *s2) {
    if (tolower((unsigned char)*s1) != tolower((unsigned char)*s2)) {
      return tolower((unsigned char)*s1) - tolower((unsigned char)*s2);
    }
    s1++;
    s2++;
  }
  return tolower((unsigned char)*s1) - tolower((unsigned char)*s2);
}

int main(int argc, char* argv[]) {
  if (argc < 3) {
    printf("Usage: %s <language: java|c> <log_file_path>\n", argv[0]);
    printf("Example:\n");
    printf("  %s java build.log\n", argv[0]);
    printf("  %s c build.log\n", argv[0]);
    printf("  cat build.log | %s java -\n", argv[0]);
    return 2;
  }

  // 1. 解析目标语言
  Language lang = LANG_UNKNOWN;
  if (str_case_cmp(argv[1], "java") == 0) {
    lang = LANG_JAVA;
  } else if (str_case_cmp(argv[1], "c") == 0) {
    lang = LANG_C;
  } else {
    fprintf(stderr, "Error: Unsupported language '%s'. Supported: 'java', 'c'\n", argv[1]);
    return 2;
  }

  // 2. 打开日志文件
  FILE* file = NULL;
  if (strcmp(argv[2], "-") == 0) {
    file = stdin;
  } else {
    file = fopen(argv[2], "r");
    if (file == NULL) {
      perror("Error opening log file");
      return 2;
    }
  }

  // 通用模式
  const char* PAT_COMMON_FREEMARKER_ERR = "freemarker template error";

  // Java 模式
  const char* PAT_JAVA_SUCCESS = "build success";
  const char* PAT_JAVA_FAILED = "build failed";

  // C 模式
  const char* PAT_C_MAKE_ERR = "make: *** [all] error";
  const char* PAT_C_TESTS_FAILED = "the following tests failed";
  const char* PAT_C_ERRORS_GEN = "error generated"; // 包含 "error generated" 和 "errors generated"

  char line[MAX_LINE_LENGTH];
  unsigned long line_num = 0;

  // 统计计数器
  int freemarker_err_count = 0;
  int java_success_count = 0;
  int java_failed_count = 0;
  int c_make_err_count = 0;
  int c_tests_failed_count = 0;
  int c_errors_gen_count = 0;

  // 逐行解析
  while (fgets(line, sizeof(line), file) != NULL) {
    line_num++;
    line[strcspn(line, "\r\n")] = '\0';

    // 所有语言通用检测：freemarker template error
    if (str_case_str(line, PAT_COMMON_FREEMARKER_ERR) != NULL) {
      freemarker_err_count++;
      printf("[ERROR][Common] Line %lu: %s\n", line_num, line);
    }

    if (lang == LANG_JAVA) {
      // Java: build success
      if (str_case_str(line, PAT_JAVA_SUCCESS) != NULL) {
        java_success_count++;
        printf("[SUCCESS][Java] Line %lu: %s\n", line_num, line);
      }
      // Java: build failed
      if (str_case_str(line, PAT_JAVA_FAILED) != NULL) {
        java_failed_count++;
        printf("[ERROR][Java]   Line %lu: %s\n", line_num, line);
      }
    } else if (lang == LANG_C) {
      // C: make: *** [all] Error
      if (str_case_str(line, PAT_C_MAKE_ERR) != NULL) {
        c_make_err_count++;
        printf("[ERROR][C]      Line %lu: %s\n", line_num, line);
      }
      // C: The following tests FAILED
      if (str_case_str(line, PAT_C_TESTS_FAILED) != NULL) {
        c_tests_failed_count++;
        printf("[ERROR][C]      Line %lu: %s\n", line_num, line);
      }
      // C: errors generated (Clang/GCC)
      if (str_case_str(line, PAT_C_ERRORS_GEN) != NULL) {
        c_errors_gen_count++;
        printf("[ERROR][C]      Line %lu: %s\n", line_num, line);
      }
    }
  }

  if (file != stdin) {
    fclose(file);
  }

  // 打印统计报告
  printf("\n==================== SCAN RESULT ====================\n");
  printf("Target Language:     %s\n", (lang == LANG_JAVA) ? "Java" : "C");
  printf("Total lines scanned: %lu\n", line_num);
  printf(" - 'freemarker template error':  %d\n", freemarker_err_count);

  if (lang == LANG_JAVA) {
    printf(" - 'build success':              %d\n", java_success_count);
    printf(" - 'build failed':               %d\n", java_failed_count);
    printf("-----------------------------------------------------\n");

    if (java_failed_count > 0 || freemarker_err_count > 0) {
      printf("FINAL RESULT: FAILURE (Java errors detected)\n");
      return 1;
    }
    if (java_success_count == 0) {
      printf("FINAL RESULT: WARNING (No errors, but 'build success' was NOT found)\n");
      return 1;
    }
    printf("FINAL RESULT: SUCCESS (Java build success, no errors found)\n");
    return 0;

  } else { // lang == LANG_C
    printf(" - 'make: *** [all] Error':      %d\n", c_make_err_count);
    printf(" - 'The following tests FAILED': %d\n", c_tests_failed_count);
    printf(" - 'errors generated':           %d\n", c_errors_gen_count);
    printf("-----------------------------------------------------\n");

    int c_total_errors = freemarker_err_count + c_make_err_count +
                         c_tests_failed_count + c_errors_gen_count;
    if (c_total_errors > 0) {
      printf("FINAL RESULT: FAILURE (C build/test errors detected)\n");
      return 1;
    }
    printf("FINAL RESULT: SUCCESS (No C errors or test failures detected)\n");
    return 0;
  }
}
