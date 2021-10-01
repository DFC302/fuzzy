# fuzzy

## Description:
Fuzzy is a quick cli fuzzer written in bash that uses cURL. While the word "quick" maybe deceiving, fuzzy isnt meant to replace your traditional and more complex fuzzers. Fuzzy was designed with simplicity in mind. Instead fuzzy is designed to quickly fuzz a URL or small subset of URLs. It can be used for content discovery and/or fuzzing endpoints. The simplicity of fuzzy is what makes it easy to use, with only 5 commands, when used in the right way, it can be very powerful.

While (for now) you would need to download the repository, most systems come with cURL, but that is all you need. No Time installing python, golang, java, etc.

## Background:
Fuzzy was created while I was on an engagement, when I needed to fuzz endpoints (sooner than later) and was having some trouble getting certain tools or languages installed. Instead of spending time trying to figure out why this tool wasn't doing exactly what I needed, I wrote what I needed instead. Hope you enjoy!

## Performance:
Fuzzy was able to process and fuzz 1497 words in 2m21s.

![image](https://user-images.githubusercontent.com/16383574/135682442-ee45e0b6-bab3-4861-ac36-9bccf05b17f0.png)



## Usage
```
        -h      Print this help menu and exit.
        -d      Domain(s) to scan. MultipleEx: "https://example.com https://example2.com"
        -D      Domain file with list of domains.
        -w      Path(s) to search. MultipleEx: "login.html login.php test/"
        -W      Wordlist file.
        -s      Parse results by status codes. MultipleEx: "200 403"
```

# Scan single domain using word/path to fuzz:
```
fuzzy -d https://domain.com/FUZZ -w test
```

# Scan single domain using words/paths to fuzz:
```
fuzzy -d https://domain.com/FUZZ -w "test test/test1 test/test2"
```

# Scan multiple domains using word/path to fuzz:
```
fuzzy -d "https://domain1.com/FUZZ https://domain2.com/FUZZ" -w test
```

# Scan multiple domains using multiple words/paths to fuzz:
```
fuzzy -d "https://domain1.com/FUZZ https://domain2.com/FUZZ" -w "test test/test1 test/test2"
```

# Use domain file or wordlist file 
```
fuzzy -D domains.txt -W wordlist.txt
```

# Print output based off status code:
```
fuzzy -d "however many domains" -w "however many words" -s 200
```
# Print output based off status code:
```
fuzzy -d "however many domains" -w "however many words" -s "200 403"
```


## Contribution:
While fuzzy fits my needs for now, it may not fit yours. If you would like to contribute, send an email or get in touch with me on Twitter @ vail__ or write some code.

<a href="https://www.buymeacoffee.com/dfc302" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
