function edgeList = getEdgeList(alpha)
    global data;
    bc = getBalanceConcentration(data);
    diff = data - bc;
    network = abs(diff) >= alpha;
    % set the main diagonal to 0
    network(logical(eye(size(network)))) = 0;
    [x, y] = find(network == 1);
    edgeList = [y, x]; 
end