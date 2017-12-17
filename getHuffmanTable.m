function getHuffmanTable(zig)
    [~, len] = size(zig);
    DCzig = zig(1:len/4);
    ACzig = zig(len/4+1:len);
    
    DCrange = 200;
    ACrange = 10;
    
    DCzig = DCzig + (DCrange+1);
    ACzig = ACzig + (ACrange+1);

    P = zeros(1, DCrange*2+1);
    Q = zeros(1, DCrange*2+1);
    for i = 1:len/4
        P(DCzig(i)) = P(DCzig(i)) + 1;
    end
    for i = 1:DCrange*2+1
        Q(i) = P(i)/(len/4);
    end
    k = -DCrange:DCrange;
    DCdict = huffmandict(k, Q);
    save huffmanDictDC DCdict;
    
    P = zeros(1, ACrange*2+1);
    Q = zeros(1, ACrange*2+1);
    for i = 1:len/4*3
        P(ACzig(i)) = P(ACzig(i)) + 1;
    end
    for i = 1:ACrange*2+1
        Q(i) = P(i)/(len/4*3);
    end
    k = -ACrange:ACrange;
    ACdict = huffmandict(k, Q);
    save huffmanDictAC ACdict;
    
end