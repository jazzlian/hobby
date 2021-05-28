#-*- coding: utf-8 -*-

"""
####################################################
# install package
# pip install pyarrow 
#
# usage:
#     python3 csv2par csvfile parquetfile
####################################################
"""

import pyarrow.parquet as pq
from pyarrow import csv
import sys, os, datetime

def pqwrite_table(csv_file, par_file):
    try:
        pq.write_table(csv.read_csv(csv_file), par_file, compression='gzip',  compression_level=9)
    except Exception:
        print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), ' : ===== Error ', csv_file, ' Convert Exception Raise =====')
        sys.exit(2)
        
def usage():
    print('Usage : csv2par.py csvfile')
    print('        csv2par.py csvfile parquetfile')
    print('')
    print('Made By msyoun@mz.co.kr')
    
def main(argv):
    
    if len(argv) > 3 or len(argv) < 2:
        usage()
        sys.exit(2)
    else:
        srcfile = os.path.abspath(argv[1])
        fname, fext = os.path.splitext(srcfile)
        
        if fext == '.csv' or fext == '.CSV':
            if len(argv) == 2:
                destfile = fname + '.parquet'
            elif len(argv) == 3:
                destfile = os.path.abspath(argv[2])
                
            print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), ' : ===== Convert Start ======')
            
            pqwrite_table(srcfile, destfile)
            
            print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), ' : ===== Convert Finish ======')
        else:
            print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), ' : ===== Error ', srcfile, ' is not csv file =====')
            sys.exit(2)
    
if __name__ == '__main__':
    main(sys.argv)