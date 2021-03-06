
library(RVowpalWabbit)

# Test 1:
# {VW} -b 17 -l 20 --initial_t 128000 --power_t 1 -d train-sets/0001.dat -f models/0001.model -c --passes 2 --compressed --ngram 3 --skips 1
test1 <- c("-b", "17",
           "-l", "20",
           "--initial_t", "128000",
           "--power_t", "1",
           "-d", system.file("test", "train-sets", "0001.dat", package="RVowpalWabbit"),
           "-f", file.path(tempdir(), "0001.model"),
           "--cache_file", file.path(tempdir(), "0001.cache"),
           "-c",
           "--passes", "2",
           "--compressed",
           "--ngram", "3",
           "--skips", "1")

# Test 2: checking predictions as well
# {VW} -t train-sets/0001.dat -i models/0001.model -p 001.predict.tmp
test2 <- c("-t", system.file("test", "train-sets", "0001.dat", package="RVowpalWabbit"),
           "-i", system.file("test", "models", "0001.model", package="RVowpalWabbit"),
           "--cache_file", file.path(tempdir(), "0001.cache"),
           "-p", file.path(tempdir(), "0001.predict.tmp"))

# Test 3: without -d, training only
# {VW} train-sets/0002.dat    -f models/0002.model
test3 <- c("-t", system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"),
           "--cache_file", file.path(tempdir(), "0002.cache"),
           "-f", file.path(tempdir(), "0002.model"))

# Test 4: same, with -d
# {VW} -d train-sets/0002.dat    -f models/0002.model
test4 <- c("-d", system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"),
           "--cache_file", file.path(tempdir(), "0002.cache"),
           "-f", file.path(tempdir(), "0002.model"))

# Test 5: add -q .., adaptive, and more (same input, different outputs)
# {VW} --initial_t 1 --power_t 0.5 --adaptive -q Tf -q ff -f models/0002a.model train-sets/0002.dat
test5 <- c("--initial_t", "1",
           "--power_t", "0.5",
           "--adaptive",
           "-q", "Tf",
           "-q", "ff",
           "-f", file.path(tempdir(), "0002a.model"),
           "--cache_file", file.path(tempdir(), "0002a.cache"),
           system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"))

# Test 6: run predictions on Test 4 model
# Pretending the labels aren't there
# {VW} -t -i models/0002.model -d train-sets/0002.dat -p 0002b.predict
test6 <- c("-t", "-i", system.file("test", "models", "0002.model", package="RVowpalWabbit"),
           "-d", system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"),
           "--cache_file", file.path(tempdir(), "0002b.cache"),
           "-p", file.path(tempdir(), "0002b.predict.tmp"))

# Test 7: using -q and multiple threads
# {VW} --adaptive -q ff -f models/0002c.model train-sets/0002.dat
test7 <- c("--adaptive", "-q", "ff",
           "-f", file.path(tempdir(), "0002c.model"),
           "--cache_file", file.path(tempdir(), "0002c.cache"),
           system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"))


## Test 8: predicts on test 7 model
## {VW} -t -i models/0002c.model -d train-sets/0002.dat -p 0002c.predict
test8 <- c("-t",
           "-i", system.file("test", "models", "0002c.model", package="RVowpalWabbit"),
           "-d", system.file("test", "train-sets", "0002.dat", package="RVowpalWabbit"),
           "--cache_file", file.path(tempdir(), "0002c.cache"),
           "-p", file.path(tempdir(), "0002c.predict.tmp"))


## combine the tests
alltests <- list(test1, test2, test3, test4, test5, test6, test7, test8)

## and run them
res <- do.call(rbind, lapply(alltests, vw) )    # run the eight tests

print(res)
