function [ rad ] = CalcProd( v1, v2 )
    
    prod = v1.x * v2.x + v1.y * v2.y;
    rad = acos(prod);
    
end

