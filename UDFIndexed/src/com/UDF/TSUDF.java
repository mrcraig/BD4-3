package com.UDF;

import java.text.SimpleDateFormat;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;

public class TSUDF extends UDF {
	public Text evaluate(BytesWritable b){
		if(b==null)
			return null;
		else {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
			return new Text(dateFormat.format(b.getBytes()));
		}
	}
}
