--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.nils_auflage SET
 wup_id = Z.wup_id FROM dbp_data.vaus_wup AS Z
WHERE nils_auflage.mandant_id = Z.mandant_id AND SUBSTR(nils_auflage.markt_id, 1, 4) = CAST(Z.wup_id AS STRING);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


UPDATE dbp_data.vaus_wup SET
 auflage_wup_verteilgebiet = CAST(u.anteil_anz_verteilgebiet_ AS INTEGER),
 auflage_wup_auslage = CAST(u.anz_marktauslage_ AS INTEGER),
 nils_verteilgebiet_id = CAST(u.verteilgebiet_id_ AS INTEGER) FROM (SELECT mandant_id,
   wup_id,
   MAX(verteilgebiet_id) AS verteilgebiet_id_,
   SUM(anz_marktauslage) AS anz_marktauslage_,
   SUM(anteil_anz_verteilgebiet) AS anteil_anz_verteilgebiet_
  FROM (SELECT n.mandant_id,
     n.wup_id,
     n.verteilgebiet_id,
     n.anz_marktauslage,
     COALESCE(ROUND(CAST(CASE
          WHEN COALESCE(SUM(v.ums_netto_plan) OVER (PARTITION BY n.mandant_id, n.verteilgebiet_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) <> 0
          THEN CAST(v.ums_netto_plan AS NUMERIC) / CAST(SUM(v.ums_netto_plan) OVER (PARTITION BY n.mandant_id, n.verteilgebiet_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS NUMERIC)
           
          ELSE 1.0000
          END * n.anz_verteilgebiet AS BIGNUMERIC), 0), 0) AS anteil_anz_verteilgebiet
    FROM (SELECT mandant_id,
       wup_id,
       ROUND(CAST(verteilgebiet_id AS BIGNUMERIC), 0) AS verteilgebiet_id,
       ROUND(CAST(anz_marktauslage AS BIGNUMERIC), 0) AS anz_marktauslage,
       ROUND(CAST(anz_verteilgebiet AS BIGNUMERIC), 0) AS anz_verteilgebiet
      FROM dbp_etl.nils_auflage AS N
      WHERE mandant_id <> 6) AS n
     LEFT JOIN (SELECT U.mandant_id,
       U.wup_id,
       SUM(U.umsatz_netto_plan) AS ums_netto_plan
      FROM dbp_data.wup_plan_tag AS U
       INNER JOIN dbp_data.tag AS T ON U.dat = T.dat AND EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) * 100 + EXTRACT(MONTH
           FROM CURRENT_DATE("Europe/Berlin")) = T.kjmo
      GROUP BY U.wup_id,
       U.mandant_id) AS v ON n.mandant_id = v.mandant_id AND n.wup_id = v.wup_id) AS a
  GROUP BY mandant_id,
   wup_id) AS u
WHERE vaus_wup.mandant_id = u.mandant_id AND vaus_wup.wup_id = u.wup_id;