#!/bin/bash -e

suites='
trivial toys
jason neil peter ilya
imaginary
compile-time
contracts
'

test -r blacklist || exit 11

for suite in $suites ;do

for f in examples/"$suite"/*.core ;do

t=${f#examples/}
t=${t%.core}
grep -qe "^${t}$" blacklist && continue

stack exec hscp-mb-exe -- -v0 "$f"

done

done
