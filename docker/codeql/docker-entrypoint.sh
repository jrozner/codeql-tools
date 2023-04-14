#!/bin/bash

set -e

unset lang
unset repo
unset indir
unset outdir

usage() {
  cat << EOF
Usage: $0 [OPTIONS]

  -l <language>  the langugage to use
  -r <repo>      URL to repository to build database from
  -i <dir>       input directory to build the database from
  -o <dir>       output directory for database archive
EOF
}

while getopts "l:r:i:o:" arg; do
  case "${arg}" in
    l)
      lang=${OPTARG}
      ;;
    r)
      repo=${OPTARG}
      ;;
    i)
      indir=${OPTARG}
      ;;
    o)
      outdir=${OPTARG}
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

if [ -z $lang ]; then
  echo "error: language cannot be empty"
  exit 1
fi

if [ -z $repo ] && [ -z $indir ]; then
  echo "error: must specify a repository or input directory"
  exit 1
fi

if [ -n $repo ]; then
  git clone --depth 1 $repo
  indir=$(basename $repo | sed -e 's/\.git//')
fi

if [ -z $outdir ]; then
  outdir=$(pwd)
fi

# TODO: change `database` to the name of the repo so it looks good in codeql

codeql database create -l $lang -s $indir database
codeql database bundle -o $outdir/$indir.zip database

#if [ $UPLOAD ]; then
#  curl -d "language=$LANG&" $DATABASE_STORE/databases/new
#fi
