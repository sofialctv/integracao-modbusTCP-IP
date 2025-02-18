void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void PLANTA_init__(PLANTA *data__, BOOL retain) {
  __INIT_VAR(data__->SP,50,retain)
  __INIT_VAR(data__->PV,0,retain)
  __INIT_VAR(data__->CV,0,retain)
  __INIT_VAR(data__->ITERM,0,retain)
  __INIT_VAR(data__->ERROR,0,retain)
  __INIT_VAR(data__->KP,3,retain)
  __INIT_VAR(data__->KI,13,retain)
  __INIT_VAR(data__->R1,__BOOL_LITERAL(FALSE),retain)
  INTEGRAL_init__(&data__->INTEGRAL0,retain);
  __INIT_VAR(data__->_TMP_UINT_TO_REAL5_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV6_OUT,0,retain)
  __INIT_VAR(data__->_TMP_ADD7_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL21_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL9_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_UINT10_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL17_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL16_OUT,0,retain)
  __INIT_VAR(data__->_TMP_SUB18_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL23_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL28_OUT,0,retain)
  __INIT_VAR(data__->_TMP_UINT_TO_REAL29_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV25_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_TIME24_OUT,__time_to_timespec(1, 0, 0, 0, 0, 0),retain)
}

// Code part
void PLANTA_body__(PLANTA *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,_TMP_UINT_TO_REAL5_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)__GET_VAR(data__->KI,)));
  __SET_VAR(data__->,_TMP_DIV6_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->ITERM,),
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL5_OUT,)));
  __SET_VAR(data__->,_TMP_ADD7_OUT,,ADD__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_DIV6_OUT,),
    (REAL)__GET_VAR(data__->ERROR,)));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL21_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)__GET_VAR(data__->KP,)));
  __SET_VAR(data__->,_TMP_MUL9_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_ADD7_OUT,),
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL21_OUT,)));
  __SET_VAR(data__->,_TMP_REAL_TO_UINT10_OUT,,REAL_TO_UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_MUL9_OUT,)));
  __SET_VAR(data__->,CV,,__GET_VAR(data__->_TMP_REAL_TO_UINT10_OUT,));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL17_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)__GET_VAR(data__->SP,)));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL16_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)__GET_VAR(data__->PV,)));
  __SET_VAR(data__->,_TMP_SUB18_OUT,,SUB__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL17_OUT,),
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL16_OUT,)));
  __SET_VAR(data__->,ERROR,,__GET_VAR(data__->_TMP_SUB18_OUT,));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL23_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)0));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL28_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)100));
  __SET_VAR(data__->,_TMP_UINT_TO_REAL29_OUT,,UINT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)1000));
  __SET_VAR(data__->,_TMP_DIV25_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL28_OUT,),
    (REAL)__GET_VAR(data__->_TMP_UINT_TO_REAL29_OUT,)));
  __SET_VAR(data__->,_TMP_REAL_TO_TIME24_OUT,,REAL_TO_TIME(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_DIV25_OUT,)));
  __SET_VAR(data__->INTEGRAL0.,RUN,,__BOOL_LITERAL(TRUE));
  __SET_VAR(data__->INTEGRAL0.,R1,,__GET_VAR(data__->R1,));
  __SET_VAR(data__->INTEGRAL0.,XIN,,__GET_VAR(data__->ERROR,));
  __SET_VAR(data__->INTEGRAL0.,X0,,__GET_VAR(data__->_TMP_UINT_TO_REAL23_OUT,));
  __SET_VAR(data__->INTEGRAL0.,CYCLE,,__GET_VAR(data__->_TMP_REAL_TO_TIME24_OUT,));
  INTEGRAL_body__(&data__->INTEGRAL0);
  __SET_VAR(data__->,ITERM,,__GET_VAR(data__->INTEGRAL0.XOUT,));

  goto __end;

__end:
  return;
} // PLANTA_body__() 





