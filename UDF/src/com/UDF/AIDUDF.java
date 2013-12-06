package com.UDF;
import java.util.Arrays;

import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.LongWritable;
import org.hsqldb.types.Binary;


public class AIDUDF extends UDF {
	public LongWritable evaluate(BytesWritable b){
		if(b==null)
			return null;
		else
			return new LongWritable(Bytes.toLong(Arrays.copyOfRange(b.getBytes(), 0, 8)));
	}
}
