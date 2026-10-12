CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_VAT_HIST_SAP_1 as
   /*	
   #DescStart#	
   #$Revision: 6968 $, $LastChangedBy: mmurtenthaler $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd#	
   */	
   SELECT	
     client_id,	
   item_sid,	
   country_pol_cd,	
   vat_id,	
   vat_value,	
   vat_descr,	
   dwh_valid_from,	
   dwh_valid_to	
  FROM  (	
  /* ex CORE wenn zu einem Zeitpunkt mehre VAT-Beziehungen existieren pro Item_1 */	
    SELECT	
      client_id,	
   item_sid,	
   country_pol_cd,	
   vat_id,	
   vat_value,	
   vat_descr,	
 	
    	
  dateadd(day,-1,min(starti)) AS dwh_valid_from,	
  max(endi) AS dwh_valid_to	
  FROM (	
      SELECT --NORMALIZE	
        d.client_id,	
   d.item_sid,	
   d.country_pol_cd,	
      	
   (c.cal_dt-1) as starti,	
   (c.cal_dt) as endi,	
     	
   Coalesce(h.vat_id, i.vat_id) AS vat_id,	
   Coalesce(h.pct_vat, i.pct_vat) AS vat_value,	
   Coalesce(h.vat_desc, i.vat_desc) AS vat_descr	
      -- Elwis: Erster Zugriff f�r MWST Inland (nur VAT Schl�ssel)	
      FROM	
   p_lew_core_ac.v_item_tax_country_hist_1 d	
   INNER JOIN p_lew_core_ac.v_client_1 b	
   ON b.client_id = d.client_id	
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 c	
   ON c.cal_dt BETWEEN DATE'2006-03-01' AND Current_Date	
   AND c.cal_dt BETWEEN d.dwh_valid_from AND d.dwh_valid_to	
   LEFT OUTER JOIN p_lew_core_ac.v_map_mis_tax_class_1 g	
   ON g.client_id = d.client_id	
   AND g.tax_class_cd = d.tax_class_cd	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 h	
   ON h.client_id = g.client_id	
   AND h.vat_id = g.mis_vat_id	
   AND c.cal_dt BETWEEN h.dat_rec_start AND h.dat_rec_end	
   LEFT OUTER JOIN    (	
   SELECT	
     client_id,	
   vat_id,	
   pct_vat,	
   vat_desc,	
   dat_rec_start,	
   dat_rec_end	
        FROM p_lew_core_ac.v_wawi_ref_vat_1	
        WHERE client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 WHERE vat_id > 0)	
        AND language_id = 7	
        GROUP BY 1,2,3,4,5,6	
      ) i	
   ON i.client_id = g.client_id	
   AND i.vat_id = g.mis_vat_id	
   AND c.cal_dt BETWEEN i.dat_rec_start AND i.dat_rec_end	
   LEFT OUTER JOIN	
   (--alle moeglichen duplikate mit vat_id>=0	
    SELECT	
        f0.client_id,	
   f0.item_sid,	
   f0.dwh_valid_from,	
   f0.dwh_valid_to,	
   f0.country_pol_cd,	
   Coalesce(h2.dat_rec_start,Cast('19000101' AS VARCHAR)) dat_rec_start_h2,	
   Coalesce(h2.dat_rec_end,Cast('99991231' AS VARCHAR)) dat_rec_end_h2,	
   Coalesce(i2.dat_rec_start,Cast('19000101' AS VARCHAR)) dat_rec_start_i2,	
   Coalesce(i2.dat_rec_end,Cast('99991231' AS VARCHAR)) dat_rec_end_i2	
        FROM p_lew_core_ac.v_item_tax_country_hist_1 f0	
   LEFT OUTER JOIN p_lew_core_ac.v_map_mis_tax_class_1 g2	
   ON g2.client_id = f0.client_id	
   AND g2.tax_class_cd = f0.tax_class_cd	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 h2	
   ON h2.client_id = g2.client_id	
   AND h2.vat_id = g2.mis_vat_id	
   LEFT OUTER JOIN	
   (	
    SELECT	
       client_id,	
   vat_id,	
   pct_vat,	
   vat_desc,	
   dat_rec_start,	
   dat_rec_end	
         FROM p_lew_core_ac.v_wawi_ref_vat_1	
         WHERE client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 WHERE vat_id > 0)	
         AND language_id = 7	
         GROUP BY 1,2,3,4,5,6	
        ) i2	
   ON i2.client_id = g2.client_id	
   AND i2.vat_id = g2.mis_vat_id	
	
WHERE	
--es darf keinen g�ltigen treffer mit vat_id>=0 geben	
Coalesce(h2.vat_id, i2.vat_id)>=0	
AND f0.deleted_fg = 0	
) f	
   ON f.client_id = d.client_id	
   AND f.item_sid = d.item_sid	
   AND d.country_pol_cd <> b.country_cd	
   -- umgedreht auf niedrigste, damit in Nordirland GB vor IE zieht, das wurde so gewuenscht	
   AND (f.country_pol_cd < d.country_pol_cd OR f.country_pol_cd = b.country_cd)	
   AND c.cal_dt BETWEEN f.dwh_valid_from AND f.dwh_valid_to	
   AND c.cal_dt BETWEEN f.dat_rec_start_h2 AND f.dat_rec_end_h2	
   AND c.cal_dt BETWEEN f.dat_rec_start_i2 AND f.dat_rec_end_i2	
	
 WHERE	
 --kein valides Duplikat gefunden	
 f.client_id IS NULL	
 --vat_id ist annehmbar	
 AND Coalesce(h.vat_id, i.vat_id) >=0	
 -- Elwis: Zweiter Zugriff f�r MWST mit Auslandbezug (nur VAT Schl�ssel)	
 AND d.deleted_fg = 0	
 --AND d.client_id<>21	
 AND  EXISTS	
  (	
   SELECT 1 FROM p_lew_core_ac.v_item_tax_country_hist_1 u	
   WHERE u.client_id = d.client_id	
   AND u.item_sid = d.item_sid	
   AND u.country_pol_cd <> d.country_pol_cd	
   AND u.dwh_valid_from <= d.dwh_valid_to	
   AND u.dwh_valid_to >= d.dwh_valid_from	
   AND u.deleted_fg = 0	
    	
    	
  	
)	
  	
	
	
      	
      	
) dups	
	
  group by dups.client_id, dups.item_sid, dups.country_pol_cd, dups.vat_id, dups.vat_value, dups.vat_descr	
	
UNION   ALL	
	
/* ex CORE wenn zu einem Zeitpunkt nur eine_1 VAT-Beziehung existiert pro Item_1 */	
SELECT	
d.client_id,	
   d.item_sid,	
   d.country_pol_cd,	
   h.vat_id,	
   h.pct_vat AS vat_value,	
   h.vat_desc AS vat_descr,	
   CASE WHEN d.dwh_valid_from > h.dat_rec_start THEN d.dwh_valid_from ELSE h.dat_rec_start END AS dwh_valid_from,	
   CASE WHEN d.dwh_valid_to < h.dat_rec_end THEN d.dwh_valid_to ELSE h.dat_rec_end END AS dwh_valid_to	
    -- Elwis: Erster Zugriff f�r MWST Inland (nur VAT Schl�ssel)	
    FROM	
   p_lew_core_ac.v_item_tax_country_hist_1 d	
   INNER JOIN p_lew_core_ac.v_client_1 b	
   ON b.client_id = d.client_id	
   LEFT OUTER JOIN p_lew_core_ac.v_map_mis_tax_class_1 g	
   ON g.client_id = d.client_id	
   AND g.tax_class_cd = d.tax_class_cd	
   INNER JOIN  (	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   a.dat_rec_end	
      FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 a	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   b.dat_rec_start-1 AS dat_rec_end	
      FROM p_lew_core_ac.v_wawi_ref_vat_1 a	
   INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_start BETWEEN a.dat_rec_start+1 AND a.dat_rec_end	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 c	
   ON c.client_id = b.client_id	
   AND c.vat_id = b.vat_id	
   AND c.dat_rec_start BETWEEN a.dat_rec_start+1 AND b.dat_rec_start - 1	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 WHERE vat_id > 0)	
   AND language_id = 7	
   AND c.client_id IS NULL	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   b.dat_rec_end+1 AS dat_rec_start,	
   CASE WHEN c.dat_rec_start-1 < a.dat_rec_end THEN c.dat_rec_start-1 ELSE a.dat_rec_end END AS dat_rec_end	
      FROM p_lew_core_ac.v_wawi_ref_vat_1 a	
   INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_end BETWEEN a.dat_rec_start AND a.dat_rec_end - 1	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 c	
   ON c.client_id = b.client_id	
   AND c.vat_id = b.vat_id	
   AND c.dat_rec_start > b.dat_rec_start	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 d	
   ON d.client_id = c.client_id	
   AND d.vat_id = c.vat_id	
   AND d.dat_rec_start BETWEEN b.dat_rec_start AND c.dat_rec_start	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 WHERE vat_id > 0)	
   AND language_id = 7	
   AND d.client_id IS NULL	
	
   UNION ALL	
	
   SELECT	
     a.client_id,	
   a.vat_id,	
   a.pct_vat,	
   a.vat_desc,	
   a.dat_rec_start,	
   a.dat_rec_end	
      FROM p_lew_core_ac.v_wawi_ref_vat_1 a	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 b	
   ON b.client_id = a.client_id	
   AND b.vat_id = a.vat_id	
   AND b.dat_rec_end >= a.dat_rec_start	
   AND b.dat_rec_start <= a.dat_rec_end	
   WHERE a.client_id NOT IN(SELECT client_id FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 WHERE vat_id > 0)	
   AND language_id = 7 -- Duplikate aufgrund der Mehrsprachigkeit verhindern	
   AND b.client_id IS NULL	
   ) h	
   ON h.client_id = d.client_id	
   AND (h.vat_id = g.mis_vat_id OR (d.tax_class_cd IS NOT NULL AND g.mis_vat_id IS NULL AND h.vat_id=-1)) --for existing tax classes which are not in the mapping table use vat_id -1	
   AND h.dat_rec_start <= d.dwh_valid_to	
   AND h.dat_rec_end >= d.dwh_valid_from	
	
 WHERE	
   -- f.client_ mu� immer null sein. Entweder um Mehrfachtreffer zu verhindern, 	
   -- oder weil der Satz aus WAWI kommt.	
   h.vat_id>=-1 --0 replaced by -1 UM 20171106 	
	
 -- Elwis: Zweiter Zugriff f�r MWST mit Auslandbezug (nur VAT Schl�ssel)	
     AND d.deleted_fg = 0	
    --AND d.client_id<>21	
 AND  NOT EXISTS(	
   SELECT 1 FROM p_lew_core_ac.v_item_tax_country_hist_1 u	
   WHERE u.client_id = d.client_id	
   AND u.item_sid = d.item_sid	
   AND u.country_pol_cd <> d.country_pol_cd	
   AND u.dwh_valid_from <= d.dwh_valid_to	
   AND u.dwh_valid_to >= d.dwh_valid_from	
   AND u.deleted_fg = 0)	
	
    	
) q	;