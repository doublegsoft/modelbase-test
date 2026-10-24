
# 编译器与编译选项
CC ?= gcc
CFLAGS ?= -O2 -Wall -Wextra -pedantic -std=c99

# 目标文件与源码
TARGET = check_log
SRCS = check_log.c
OBJS = $(SRCS:.c=.o)

# 安装路径（默认安装到 /usr/local/bin）
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

.PHONY: all clean test install uninstall

# 默认构建目标
all: $(TARGET)

# 链接可执行文件
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# 编译 .c 文件到 .o 文件
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# 清理构建产物和临时日志
clean:
	rm -f $(TARGET) $(OBJS) test_*.log

# 快速自测目标（测试 Java 与 C 的各种匹配逻辑）
test: $(TARGET)
	@echo "========== 开始运行自动化测试 =========="
	@# 1. 测试 Java 成功场景
	@echo "[INFO] BUILD SUCCESS" > test_java_pass.log
	@./$(TARGET) java test_java_pass.log > /dev/null && \
		echo "[PASS] Java 成功日志检测正确" || (echo "[FAIL] Java 成功检测异常"; exit 1)
	@# 2. 测试 Java 失败场景
	@echo "BUILD FAILED" > test_java_fail.log
	@! ./$(TARGET) java test_java_fail.log > /dev/null && \
		echo "[PASS] Java 失败日志拦截正确" || (echo "[FAIL] Java 失败检测异常"; exit 1)
	@# 3. 测试 FreeMarker 通用报错拦截
	@echo "FreeMarker template error: null pointer" > test_fm_fail.log
	@! ./$(TARGET) java test_fm_fail.log > /dev/null && \
		echo "[PASS] FreeMarker 报错拦截正确" || (echo "[FAIL] FreeMarker 检测异常"; exit 1)
	@# 4. 测试 C 语言编译报错拦截
	@echo "make: *** [all] Error 2" > test_c_fail.log
	@! ./$(TARGET) c test_c_fail.log > /dev/null && \
		echo "[PASS] C 语言 make 报错拦截正确" || (echo "[FAIL] C 语言检测异常"; exit 1)
	@rm -f test_*.log
	@echo "========== 全部测试通过 (All Passed) =========="

# 安装到系统环境
install: $(TARGET)
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(TARGET) $(DESTDIR)$(BINDIR)

# 卸载
uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(TARGET)
