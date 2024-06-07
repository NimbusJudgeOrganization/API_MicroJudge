int fatorial(int n) {
    int k, fat;
    
    fat = 1;
    for(k = 1; k <= n; k++) {
        fat *= k;
    }
    
    return fat;
}