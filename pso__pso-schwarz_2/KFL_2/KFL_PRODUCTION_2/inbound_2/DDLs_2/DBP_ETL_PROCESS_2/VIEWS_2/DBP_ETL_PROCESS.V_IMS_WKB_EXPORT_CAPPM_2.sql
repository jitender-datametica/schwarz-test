create or replace view DBP_ETL_PROCESS.V_IMS_WKB_EXPORT_CAPPM_2(
	CODE_,
	YEAR_,
	MONTH_,
	TRANSCLASS_,
	ACTUALS_,
	OBLIGO_
) as
(SELECT
y.code_,
y.year_,
y.month_,
y.transclass_,
SUM(COALESCE(z.actuals_,0)) AS actuals_,
SUM(COALESCE(z.obligo_,0)) AS obligo_
FROM (SELECT
p.code_,
q.kj AS year_,
SUBSTR(CAST(q.kjmo AS CHAR(6)),5,2) AS month_,
CASE
WHEN r.berichts_position_it_id =  1 THEN 'INVSWIT'
WHEN r.berichts_position_it_id =  2 THEN 'INVSWNIT'
WHEN r.berichts_position_it_id =  3 THEN 'INVHWIT'
WHEN r.berichts_position_it_id =  4 THEN 'INVHWNIT'
WHEN r.berichts_position_it_id =  5 THEN 'SOINVIT'
WHEN r.berichts_position_it_id =  6 THEN 'SOINVNIT'
WHEN r.berichts_position_it_id =  8 THEN 'EPKITEXP'
WHEN r.berichts_position_it_id =  7 THEN 'EPKITWB'
WHEN r.berichts_position_it_id =  9 THEN 'IPKITSIT'
WHEN r.berichts_position_it_id = 10 THEN 'EPNITK'
WHEN r.berichts_position_it_id = 11 THEN 'EPNITNK'
WHEN r.berichts_position_it_id = 12 THEN 'SOKONKIS'
WHEN r.berichts_position_it_id = 13 THEN 'SOKOKIS'
WHEN r.berichts_position_it_id = 14 THEN 'IPKITKIS'
WHEN r.berichts_position_it_id = 15 THEN 'IPKNIDKI'
WHEN r.berichts_position_it_id = 16 THEN 'IPKNIKMO'
WHEN r.berichts_position_it_id = 17 THEN 'LBAEXKIS'
WHEN r.berichts_position_it_id = 18 THEN 'LBASIT'
WHEN r.berichts_position_it_id = 19 THEN 'LBAEXFB'
ELSE 'nicht bekannt' END AS transclass_
FROM (SELECT
y.code_,
MIN(y.kjmo) AS kjmo,
MIN(y.akt_mo) AS akt_mo
FROM (SELECT
c.in_projekt_id_char AS code_,
MIN(d.kjmo) AS kjmo,
MIN(d.akt_mo)-2 AS akt_mo
FROM dbp_data.ist_kosten_det_2 a
JOIN dbp_data.tag_2 d
ON a.dat_buch = d.dat
JOIN dbp_data.in_psp_element_2 b
ON a.mandant_id = b.mandant_id AND
   a.psp_id = b.psp_id
JOIN dbp_data.in_projekt_2 c
ON a.mandant_id = c.mandant_id AND
   b.in_projekt_id = c.in_projekt_id
WHERE c.in_projekt_id_char IN (SELECT
it_projekt_id
FROM dbp_data.it_projekt_plan_2)
	        GROUP BY 1
UNION
SELECT
c.in_projekt_id_char AS code_,
MIN(d.kjmo) AS kjmo,
MIN(d.akt_mo)-2 AS akt_mo
FROM dbp_data.obligo_per_2 a
JOIN dbp_data.tag_2 d
ON a.dat_buch = d.dat
JOIN dbp_data.in_psp_element_2 b
ON a.mandant_id = b.mandant_id AND
   a.psp_id = b.psp_id
JOIN dbp_data.in_projekt_2 c
ON a.mandant_id = c.mandant_id AND
   b.in_projekt_id = c.in_projekt_id
WHERE c.in_projekt_id_char IN (SELECT
it_projekt_id
FROM dbp_data.it_projekt_plan_2)
	        GROUP BY 1) y
			GROUP BY 1) p
	  JOIN dbp_data.monat_2 q
ON q.akt_mo >= p.akt_mo
JOIN dbp_data.l_berichts_pos_it_2 r
ON 1 = 1
WHERE q.akt_mo <= 2 AND
    r.berichts_position_it_id NOT IN (14,15,16,19)) y
LEFT JOIN (SELECT
c.in_projekt_id_char AS code_,
d.kj AS year_,
SUBSTR(CAST(d.kjmo AS CHAR(6)),5,2) AS month_,
CASE
WHEN a.berichts_position_it_id =  1 THEN 'INVSWIT'
WHEN a.berichts_position_it_id =  2 THEN 'INVSWNIT'
WHEN a.berichts_position_it_id =  3 THEN 'INVHWIT'
WHEN a.berichts_position_it_id =  4 THEN 'INVHWNIT'
WHEN a.berichts_position_it_id =  5 THEN 'SOINVIT'
WHEN a.berichts_position_it_id =  6 THEN 'SOINVNIT'
WHEN a.berichts_position_it_id =  8 THEN 'EPKITEXP'
WHEN a.berichts_position_it_id =  7 THEN 'EPKITWB'
WHEN a.berichts_position_it_id =  9 THEN 'IPKITSIT'
WHEN a.berichts_position_it_id = 10 THEN 'EPNITK'
WHEN a.berichts_position_it_id = 11 THEN 'EPNITNK'
WHEN a.berichts_position_it_id = 12 THEN 'SOKONKIS'
WHEN a.berichts_position_it_id = 13 THEN 'SOKOKIS'
WHEN a.berichts_position_it_id = 14 THEN 'IPKITKIS'
WHEN a.berichts_position_it_id = 15 THEN 'IPKNIDKI'
WHEN a.berichts_position_it_id = 16 THEN 'IPKNIKMO'
WHEN a.berichts_position_it_id = 17 THEN 'LBAEXKIS'
WHEN a.berichts_position_it_id = 18 THEN 'LBASIT'
WHEN a.berichts_position_it_id = 19 THEN 'LBAEXFB'
ELSE 'nicht bekannt' END AS transclass_,
SUM(a.betrag*e.umrechnungskurs) AS actuals_,
CAST(SUM(0) AS DECIMAL(18,4)) AS obligo_
FROM dbp_data.ist_kosten_det_2 a
JOIN dbp_data.in_psp_element_2 b
ON a.mandant_id = b.mandant_id AND
   a.psp_id = b.psp_id
JOIN dbp_data.in_projekt_2 c
ON a.mandant_id = c.mandant_id AND
   b.in_projekt_id = c.in_projekt_id
JOIN dbp_data.tag_2 d
ON a.dat_buch = d.dat
JOIN dbp_data.kurs_2 e
ON a.wrg_id = e.von_wrg_id AND
   e.dat_bis = to_date('9999-12-31', 'YYYY-MM_2-DD') AND
   e.nach_wrg_id = 'EUR' AND
   e.kurstyp_id = 3
WHERE c.in_projekt_id_char IN (SELECT
it_projekt_id

                               
                               
                               FROM dbp_data.it_projekt_plan_2) AND
     a.berichts_position_it_id BETWEEN 1 AND 19 AND
    (a.krk_id <> 'DE02' OR a.mandant_id <> 1) AND
     c.ims_projekt_typ_id = 'P'  AND             
     b.statistisch_fg  = 1 
     AND LTRIM( TRIM(collate(a.kostenart_id, '')), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '48011', '940003') 
     AND a.hb2_fg = 1
           
 GROUP BY 1,2,3,4
UNION ALL
SELECT
c.in_projekt_id_char AS code_,
d.kj AS year_,
SUBSTR(CAST(d.kjmo AS CHAR(6)),5,2)  AS month_,
CASE
WHEN a.berichts_position_it_id =  1 THEN 'INVSWIT'
WHEN a.berichts_position_it_id =  2 THEN 'INVSWNIT'
WHEN a.berichts_position_it_id =  3 THEN 'INVHWIT'
WHEN a.berichts_position_it_id =  4 THEN 'INVHWNIT'
WHEN a.berichts_position_it_id =  5 THEN 'SOINVIT'
WHEN a.berichts_position_it_id =  6 THEN 'SOINVNIT'
WHEN a.berichts_position_it_id =  8 THEN 'EPKITEXP'
WHEN a.berichts_position_it_id =  7 THEN 'EPKITWB'
WHEN a.berichts_position_it_id =  9 THEN 'IPKITSIT'
WHEN a.berichts_position_it_id = 10 THEN 'EPNITK'
WHEN a.berichts_position_it_id = 11 THEN 'EPNITNK'
WHEN a.berichts_position_it_id = 12 THEN 'SOKONKIS'
WHEN a.berichts_position_it_id = 13 THEN 'SOKOKIS'
WHEN a.berichts_position_it_id = 14 THEN 'IPKITKIS'
WHEN a.berichts_position_it_id = 15 THEN 'IPKNIDKI'
WHEN a.berichts_position_it_id = 16 THEN 'IPKNIKMO'
WHEN a.berichts_position_it_id = 17 THEN 'LBAEXKIS'
WHEN a.berichts_position_it_id = 18 THEN 'LBASIT'
WHEN a.berichts_position_it_id = 19 THEN 'LBAEXFB'
ELSE 'nicht bekannt' END AS transclass_,
CAST(SUM(0) AS DECIMAL(18,4)) AS actuals_,
SUM(a.betrag*e.umrechnungskurs) AS obligo_
FROM dbp_data.obligo_per_2 a
JOIN dbp_data.in_psp_element_2 b
ON a.mandant_id = b.mandant_id AND
   a.psp_id = b.psp_id
JOIN dbp_data.in_projekt_2 c
ON a.mandant_id = c.mandant_id AND
   b.in_projekt_id = c.in_projekt_id
JOIN dbp_data.tag_2 d
ON a.dat_buch = d.dat
JOIN dbp_data.kurs_2 e
ON a.wrg_id = e.von_wrg_id AND
   e.dat_bis = to_date('9999-12-31', 'YYYY-MM_2-DD') AND
   e.nach_wrg_id = 'EUR' AND
   e.kurstyp_id = 3
WHERE c.in_projekt_id_char IN (SELECT
it_projekt_id
FROM dbp_data.it_projekt_plan_2) AND
     a.berichts_position_it_id BETWEEN 1 AND 19 AND
     (a.krk_id <> 'DE02' OR a.mandant_id <> 1) AND
     c.ims_projekt_typ_id = 'P'  AND
     b.statistisch_fg  = 1 AND NOT
a.kostenart_id LIKE ('%912000%') or
a.kostenart_id like ('%979002%') or
a.kostenart_id like ('%H912000%') or 
a.kostenart_id like ('%H979002%') or 
a.kostenart_id like ('%48011%') AND           
a.dat_bis = to_date('9999-12-31', 'YYYY-MM_2-DD') 
GROUP BY 1,2,3,4) z
ON y.code_ = z.code_ AND
y.year_ = z.year_ AND
y.month_ = z.month_ AND
y.transclass_ = z.transclass_
GROUP BY 1,2,3,4);