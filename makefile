# 컴파일러. CC는 관습적 이름.
CC = g++

# C++ 컴파일러 옵션
CXXFLAGS = -Wall -O2

#링커 옵션
LDFLAGS =

#소스파일 디렉토리
SRC_DIR = ./src

#오브젝트파일 디렉토리
OBJ_DIR = ./obj

#생성하고자 하는 실행 파일 이름
TARGET = main

# Make할 소스 파일들 
SRCS = $(notdir $(wildcard $(SRC_DIR)/*.cc))

# 오브젝트 파일 이름들
OBJS = $(SRCS:.cc=.o)

# OBJS 앞에 디렉토리 명을 붙인다. pattern substitution. $(OBJS)의 %.o 패턴에 해당하는 것을 $(OBJ_DIR)/%.o 로 바꿔라.
OBJECTS = $(patsubst %.o, $(OBJ_DIR)/%.o, $(OBJS))
# Dependencies
DEPS = $(OBJECTS:.o=.d)

# 틈새 문법 공부
# A := ${B} 이때, B는 정의되지 않았으므로 A는 빈 문자열이다. 
# A =  ${B} 이때, A는 B가 정의될 때까지 기다렸다가 B가 정의되면 A도 정의된다.

#make all 또는 그냥 make를 하면 make main이 먼저 실행이 되고 나머지 타겟은 dependency에 따라 실행된다.
all : main

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cc
	$(CC) $(CXXFLAGS) -c $< -o $@ -MD $(LDFLAGS)

$(TARGET) : $(OBJECTS)
	$(CC) $(CXXFLAGS) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

.PHONY : clean all
clean :
	rm -f $(TARGET) $(OBJECTS) $(DEPS)

-include $(DEPS)