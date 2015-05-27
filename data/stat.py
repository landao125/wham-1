#!/usr/bin/env python



import os, sys, getopt, shutil, re, glob



verbose = 0



def usage():
  ''' print usage and die '''

  print """  Usage:
    %s [OPTIONS] input.log""" % sys.argv[0]

  print """
  Compute statistics

  OPTIONS:
    -v              be verbose
    --verbose=      set verbocity
    -h, --help      help
  """
  exit(1)



def doargs():
  ''' handle input arguments '''
  try:
    opts, args = getopt.gnu_getopt(sys.argv[1:],
        "hv",
        [ "help", "verbose=",
        ] )
  except getopt.GetoptError, err:
    print str(err)
    usage()

  global verbose

  for o, a in opts:
    if o in ("-v",):
      verbose += 1  # such that -vv gives verbose = 2
    elif o in ("-h", "--help"):
      usage()

  if len(args):
    return args
  else:
    return glob.glob("*.log")



def dostat(fninp):
  s = open(fninp).readlines()

  n = len(s)
  m = len(s[0].strip().split())
  sy = [0.0] * m
  syy = [0.0] * m
  for i in range(n):
    arr = [float(x) for x in s[i].strip().split()]
    for j in range(m):
      x = arr[j]
      sy[j] += x
      syy[j] += x * x

  ave = [0.0] * m
  var = [0.0] * m
  for j in range(m):
    ave[j] = sy[j] / n;
    var[j] = syy[j] / n - ave[j] * ave[j]

  # write the output file
  s = "# %d %d\n" % (n, m)
  for j in range(m):
    s += "%d %g %g\n" % (j, ave[j], (var[j]*n/(n-1))**0.5)

  fnout = fninp.split(".")[0] + "wham.dat"
  open(fnout, "w").write(s)
  print "save results to %s" % fnout



if __name__ == "__main__":
  fninps = doargs()
  for fninp in fninps:
    dostat(fninp)