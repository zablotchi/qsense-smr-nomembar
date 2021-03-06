/*
 * File:
 *   intset.c
 * Author(s):
 *   Vincent Gramoli <vincent.gramoli@epfl.ch>
 * Description:
 *   Lock-based skip list integer set operations
 *
 * Copyright (c) 2009-2010.
 *
 * intset.c is part of Synchrobench
 * 
 * Synchrobench is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, version 2
 * of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include "intset.h"

inline strval_t
sl_contains(sl_intset_t *set, strkey_t key)
{
  return optimistic_find(set, key);
}

inline int
sl_add(sl_intset_t *set, strkey_t key, strval_t val)
{  
  return optimistic_insert(set, key, val);
}

inline strval_t
sl_remove(sl_intset_t *set, strkey_t key)
{
  return optimistic_delete(set, key);
}
