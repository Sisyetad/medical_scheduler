t = int(input())
for _ in range(t):
    n, h = map(int, input().split())
    total_rope = 0
    for _ in range(n):
        w, l = map(int, input().split())
        total_rope += max(w, l)
    if total_rope >= h:
        print("YES")
    else:
        print("NO")

