#include <iostream>

int func(int n) {
    if (n < 2) return 1;
    else return func(n/2) + func(n/4) + n;
}

int main() {
    for (int i = 0; i < 10; ++i){
        std::cout << func(i) << '\n';
    }
}