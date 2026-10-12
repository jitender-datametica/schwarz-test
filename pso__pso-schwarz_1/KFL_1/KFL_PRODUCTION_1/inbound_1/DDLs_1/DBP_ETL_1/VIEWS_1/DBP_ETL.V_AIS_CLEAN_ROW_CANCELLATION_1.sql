create or replace view DBP_ETL.V_AIS_CLEAN_ROW_CANCELLATION_1(
	MANDANT_ID,
	WUP_ID,
	BON_DAT,
	BON_ID,
	KL_ART_ID,
	UMSATZ_BRUTTO,
	BON_ZEILE,
	TALON_ID
) as (
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                     WHEN b.anzahl >= 1 
                             THEN b.umsatz_brutto
                             ELSE NULL
                           END
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 1 --Richtiger Bezugsweg 
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 2 
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 2
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 3
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 3
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) =3
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 4
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 4
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 4
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 5
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 5
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 5
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 6
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 6
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 6
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 7
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 7
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 7
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 8
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 8
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 8
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 9
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 9
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 9
UNION
SELECT a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
	   a.umsatz_brutto,
       a.bon_zeile,
	   a.talon_id
FROM dbp_etl.bon_kopf_verkauf_1 a
JOIN (SELECT mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			 COUNT(*) AS anzahl
      FROM dbp_etl.bon_kopf_verkauf_1
      WHERE menge < 0 AND
            talon_id <> 0
	  GROUP BY 1,2,3,4,5,6,7) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.bon_dat = b.bon_dat AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id AND
     a.ean_kasse = b.ean_kasse AND
    (-1)*a.umsatz_brutto = CASE
	                         WHEN b.anzahl >= 10
							 THEN b.umsatz_brutto
							 ELSE NULL
						   END
--QUALIFY CSUM(1,a.bon_zeile DESC) = 10
--GROUP BY 1,2,3,4,5,6
QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto ORDER BY a.bon_zeile DESC) = 10
UNION
SELECT mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
	   umsatz_brutto,
       bon_zeile,
	   talon_id
FROM dbp_etl.bon_kopf_verkauf_1
WHERE menge < 0 AND
      talon_id <> 0
);