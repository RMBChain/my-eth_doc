## Git设置代理
```
git config --global http.proxy  http://127.0.0.1:63108
git config --global https.proxy https://127.0.0.1:63108
```

## Git取消代理
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## Git设置用户名
```
git config --global user.name ""
git config user.name
```

## go proxy
```
GOPROXY=https://mirrors.aliyun.com/goproxy
GOPROXY=https://goproxy.cn
```

## 编译 geth
```
make geth
```

## 编译全部
```
make all
```
