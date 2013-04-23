#include<cstdio>
int n, i, j, t;
int f[21];
char a[1000];

void go(int n, int sum) {
	if (n == 0)
		return;
	int i;
	for (i = 0; i < sum; i++)
		if (n - f[i] * f[sum - 1 - i] <= 0)
			break;
		else
			n -= f[i] * f[sum - 1 - i];
	if (i) {
		a[++t] = '(';
		go((n - 1) / f[sum - 1 - i] + 1, i);
		a[++t] = ')';
	}
	a[++t] = 'X';
	if (sum - 1 - i) {
		a[++t] = '(';
		go((n - 1) % f[sum - 1 - i] + 1, sum - 1 - i);
		a[++t] = ')';
	}
}
int main() {
	a[0] = "";
	f[0] = 1;
	for (i = 1; i <= 19; i++) {
		for (j = 0; j <= i - 1; j++)
			f[i] += f[j] * f[i - 1 - j];
	}
	while (scanf("%d", &n) > 0) {
		t = 0;
		for (i = 1; i <= 19; i++)
			if (n - f[i] <= 0)
				break;
			else
				n -= f[i];
		go(n, i);
		for (i = 1; i <= t; i++)
			printf("%c", a[i]);
		printf("\n");
	}
	return 0;
}
