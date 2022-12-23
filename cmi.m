function cmiv = cmi(v1, v2, vcs)
    if nargin == 2
        c1 = det(cov(v1));
        c2 = det(cov(v2));
        c3 = det(cov(v1, v2));
        cmiv = 0.5 * log(c1 * c2 / c3);
    elseif nargin == 3
        c1 = det(cov([v1; vcs]'));
        c2 = det(cov([v2; vcs]'));
        c3 = det(cov(vcs'));
        c4 = det(cov([v1; v2; vcs]'));
        cmiv = 0.5 * log((c1 * c2) / (c3 * c4));
    end
    if cmiv == inf
        cmiv = 0;
    end
end