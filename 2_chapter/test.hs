data Expr = Val Int | Div Expr Expr

safediv :: Int -> Int -> Maybe Int
safediv n m = if m == 0 then
                Nothing
               else
                Just (n / m)

eval :: Expr -> Int
eval (Val n) = n
eval (Div x y) = eval x / eval y

eval :: Expr -> Maybe Int
eval (Val n) = Just n
eval (Div x y) = case eval x of
                    Nothing -> Nothing
                    Just n -> case eval y of
                        Nothing -> Nothing
                        Just m -> safediv n m

m >>= f = case m of
            Nothing -> Nothing
            Just x -> f x


eval :: Expr -> Maybe Int
eval (Val n) = return n
eval (Div x y) = eval x >>= (\ n ->
                eval y >>= (\ m -> 
                    safediv n m))

eval :: Expr -> Maybe Int
eval (Val n) = return n
eval (Div x y) = do n <- eval x
                    m <- eval yf
                    safediv n m