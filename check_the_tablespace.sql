SELECT d.tablespace_name, ROUND(d.current_mb/1024,2) AS current_gb, ROUND((d.current_mb - NVL(f.free_mb,0))/1024,2) AS used_gb, ROUND(NVL(f.free_mb,0)/1024,2)
  AS free_gb, ROUND(d.max_mb/1024,2)
  AS max_gb, ROUND((d.max_mb - d.current_mb)/1024,2) 
  AS autoextend_left_gb, ROUND((NVL(f.free_mb,0) + (d.max_mb - d.current_mb))/1024,2)
  AS total_free_left_gb, ROUND(((d.current_mb - NVL(f.free_mb,0)) / d.max_mb) * 100,2) 
  AS pct_used_of_max FROM ( SELECT tablespace_name, SUM(bytes)/1024/1024 current_mb, SUM(DECODE(autoextensible,'YES',maxbytes,bytes))/1024/1024 max_mb 
  FROM dba_data_files 
  GROUP BY tablespace_name ) d
  LEFT JOIN ( SELECT tablespace_name, SUM(bytes)/1024/1024 free_mb FROM dba_free_space 
  GROUP BY tablespace_name ) f ON d.tablespace_name = f.tablespace_name; TABLESPACE_NAME CURRENT_GB USED_GB FREE_GB MAX_GB AUTOEXTEND_LEFT_GB TOTAL_FREE_LEFT_GB PCT_USED_OF_MAX;
