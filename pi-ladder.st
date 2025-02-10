PROGRAM AWS
  VAR
    SP AT %IW0 : UINT := 100;
    PV AT %QW0 : UINT;
    CV AT %IW1 : UINT;
    ITERM AT %QW1 : REAL;
    error AT %QW2 : REAL;
    KP AT %IW2 : UINT := 3;
    KI AT %IW3 : UINT := 1;
    R1 AT %IW4 : BOOL;
  END_VAR
  VAR
    INTEGRAL0 : INTEGRAL;
    _TMP_UINT_TO_REAL5_OUT : REAL;
    _TMP_DIV6_OUT : REAL;
    _TMP_ADD7_OUT : REAL;
    _TMP_UINT_TO_REAL21_OUT : REAL;
    _TMP_MUL9_OUT : REAL;
    _TMP_REAL_TO_UINT10_OUT : UINT;
    _TMP_UINT_TO_REAL17_OUT : REAL;
    _TMP_UINT_TO_REAL16_OUT : REAL;
    _TMP_SUB18_OUT : REAL;
    _TMP_UINT_TO_REAL23_OUT : REAL;
    _TMP_UINT_TO_REAL28_OUT : REAL;
    _TMP_UINT_TO_REAL29_OUT : REAL;
    _TMP_DIV25_OUT : REAL;
    _TMP_REAL_TO_TIME24_OUT : TIME;
  END_VAR

  _TMP_UINT_TO_REAL5_OUT := UINT_TO_REAL(KI);
  _TMP_DIV6_OUT := DIV(ITERM, _TMP_UINT_TO_REAL5_OUT);
  _TMP_ADD7_OUT := ADD(_TMP_DIV6_OUT, error);
  _TMP_UINT_TO_REAL21_OUT := UINT_TO_REAL(KP);
  _TMP_MUL9_OUT := MUL(_TMP_ADD7_OUT, _TMP_UINT_TO_REAL21_OUT);
  _TMP_REAL_TO_UINT10_OUT := REAL_TO_UINT(_TMP_MUL9_OUT);
  CV := _TMP_REAL_TO_UINT10_OUT;
  _TMP_UINT_TO_REAL17_OUT := UINT_TO_REAL(SP);
  _TMP_UINT_TO_REAL16_OUT := UINT_TO_REAL(PV);
  _TMP_SUB18_OUT := SUB(_TMP_UINT_TO_REAL17_OUT, _TMP_UINT_TO_REAL16_OUT);
  error := _TMP_SUB18_OUT;
  _TMP_UINT_TO_REAL23_OUT := UINT_TO_REAL(0);
  _TMP_UINT_TO_REAL28_OUT := UINT_TO_REAL(100);
  _TMP_UINT_TO_REAL29_OUT := UINT_TO_REAL(1000);
  _TMP_DIV25_OUT := DIV(_TMP_UINT_TO_REAL28_OUT, _TMP_UINT_TO_REAL29_OUT);
  _TMP_REAL_TO_TIME24_OUT := REAL_TO_TIME(_TMP_DIV25_OUT);
  INTEGRAL0(RUN := TRUE, R1 := R1, XIN := error, X0 := _TMP_UINT_TO_REAL23_OUT, CYCLE := _TMP_REAL_TO_TIME24_OUT);
  ITERM := INTEGRAL0.XOUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : AWS;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "76a76953519f76bafde65d4171fa1590";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern AWS RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.SP), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PV), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CV), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ITERM), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ERROR), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.KP), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.KI), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.RUN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.R1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.XIN), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.X0), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.CYCLE), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.INTEGRAL0.XOUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL5_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_DIV6_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD7_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL21_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL9_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_UINT10_OUT), UINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL17_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL16_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SUB18_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL23_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL28_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_UINT_TO_REAL29_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_DIV25_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_TIME24_OUT), TIME_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               31*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return sizeof(REAL);*)
(*DBG:    case UINT_ENUM:*)
(*DBG:        return sizeof(UINT);*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return sizeof(TIME);*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return (void *)&((__IEC_REAL_t *) ptr)->value;*)
(*DBG:    case UINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_UINT_t *) ptr)->value;*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return (void *)&((__IEC_TIME_t *) ptr)->value;*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case REAL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_REAL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_REAL_t *) ptr)->value = *((REAL *) val);*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case UINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_UINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_UINT_t *) ptr)->value = *((UINT *) val);*)
(*DBG:            ((__IEC_UINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case TIME_ENUM: {*)
(*DBG:            memcpy(&((__IEC_TIME_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_TIME_t *) ptr)->value = *((TIME *) val);*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case REAL_ENUM:*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case UINT_ENUM:*)
(*DBG:            ((__IEC_UINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case TIME_ENUM:*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)