m4_dnl harness.h.m4
m4_dnl (part of complex test harness, not of the library)
m4_dnl - function and other declarations

m4_dnl  This file is part of adns, which is Copyright (C) 1997-1999 Ian Jackson
m4_dnl  
m4_dnl  This program is free software; you can redistribute it and/or modify
m4_dnl  it under the terms of the GNU General Public License as published by
m4_dnl  the Free Software Foundation; either version 2, or (at your option)
m4_dnl  any later version.
m4_dnl  
m4_dnl  This program is distributed in the hope that it will be useful,
m4_dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
m4_dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
m4_dnl  GNU General Public License for more details.
m4_dnl  
m4_dnl  You should have received a copy of the GNU General Public License
m4_dnl  along with this program; if not, write to the Free Software Foundation,
m4_dnl  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. 

m4_include(hmacros.i4)

#ifndef HARNESS_H_INCLUDED
#define HARNESS_H_INCLUDED

#include <sys/time.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>
#include <sys/poll.h>

#include "internal.h"

/* We override several system calls with #define's */

hm_create_proto_h
m4_define(`hm_syscall', `int H$1(hm_args_massage($3,void));')
m4_include(`hsyscalls.i4')

int Hwritev(int fd, const struct iovec *vector, size_t count);
int Hgettimeofday(struct timeval *tv, struct timezone *tz);

/* There is a Q function (Q for Question) for each such syscall;
 * it constructs a string representing the call, and calls Q_str
 * on it, or constructs it in vb and calls Q_vb;
 */

hm_create_proto_q
m4_define(`hm_syscall', `void Q$1(hm_args_massage($3,void));')
m4_include(`hsyscalls.i4')

void Q_vb(void);

/* General help functions */

void Tfailed(const char *why);
void Toutputerr(void);
void Tnomem(void);
void Tfsyscallr(const char *fmt, ...) PRINTFFORMAT(1,2);
void Tensureoutputfile(void);
void Tmust(const char *call, const char *arg, int cond);

void Tvbf(const char *fmt, ...) PRINTFFORMAT(1,2);
void Tvbvf(const char *fmt, va_list al);
void Tvbfdset(int max, const fd_set *set);
void Tvbpollfds(const struct pollfd *fds, int nfds);
void Tvbaddr(const struct sockaddr *addr, int addrlen);
void Tvbbytes(const void *buf, int len);
void Tvberrno(int e);
void Tvba(const char *str);

/* Shared globals */

extern vbuf vb;
extern struct timeval currenttime;
extern const struct Terrno { const char *n; int v; } Terrnos[];
  
#endif
