--------------------------------------------------------------------------------
-- Estructuras de Datos. 2o Curso. ETSI Informática. UMA -----------------------
--------------------------------------------------------------------------------
-- Titulación: Grado en Ingeniería del Software --------------------------------
-- Alumno: GARAU MADRIGAL, Alejandro -------------------------------------------
-- Fecha de entrega:  23 | Octubre | 2017 --------------------------------------
--------------------------------------------------------------------------------
-- Relación de Ejercicios 2. Ejercicios resueltos: -----------------------------
--------------------------------------------------------------------------------
module WellBalanced where

import qualified DataStructures.Stack.LinearStack as S

wellBalanced :: String -> Bool
wellBalanced xs = wellBalanced' xs S.empty

wellBalanced' :: String -> S.Stack Char -> Bool
wellBalanced' [] s      = S.isEmpty s
wellBalanced' (x:xs) s  | x == '('  = wellBalanced' xs (S.push x s)
                        | x == '{'  = wellBalanced' xs (S.push x s)
                        | x == '['  = wellBalanced' xs (S.push x s)
                        | x == ')' && S.top s == '(' = wellBalanced' xs (S.pop s)
                        | x == '}' && S.top s == '{' = wellBalanced' xs (S.pop s)
                        | x == ']' && S.top s == '[' = wellBalanced' xs (S.pop s)
                        | otherwise = wellBalanced' xs s


-- pushPila :: S.Stack
