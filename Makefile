# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlerma-c <dlerma-c@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/24 15:52:49 by dlerma-c          #+#    #+#              #
#    Updated: 2021/12/04 11:18:40 by dlerma-c         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#··············································································#
#                                   NAMES                                      #
#··············································································#

NAME = pipex

#··············································································#
#                                    PATH                                      #
#··············································································#

OBJ_PATH = obj
SRC_PATH = src
INC_PATH = inc
LBFT_PATH = lbft

#··············································································#
#                                    LIBS                                      #
#··············································································#

# flags librerias
# ruta .a
LDFLAGS = -L $(LBFT_PATH)

# nombre lib
LDLIBS = -lft

#··············································································#
#                                    SRCS                                      #
#··············································································#

SRCS = main.c pipex_utils.c make_process.c
OBJS_NAME = $(SRCS:%.c=%.o)
OBJS = $(addprefix $(OBJ_PATH)/, $(OBJS_NAME))

#··············································································#
#                                    FLAGS                                     #
#··············································································#

CC = gcc
CFLAGS = -Wall -Werror -Wextra -g3
#include <xx.h> // path of .h
CFLAGS += -I $(INC_PATH) -I $(LBFT_PATH)

#··············································································#
#                                    RULES                                     #
#··············································································#

.PHONY: all re clean fclean

all: $(NAME)

$(NAME): $(OBJS)
	make -C $(LBFT_PATH)
	$(CC) $^ -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)

debug: CFLAGS += -fsanitize=address -g3
debug: $(NAME)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJS): | $(OBJ_PATH)

$(OBJ_PATH): 
	mkdir -p $(OBJ_PATH) 2> /dev/null

clean:
	make fclean -C $(LBFT_PATH)
	rm -rf $(OBJ_PATH)

fclean: clean
	rm -rf $(NAME)

re: fclean all
