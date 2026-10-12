CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_ART_PER_MONAT_2

--23.06.2017: ttez SPEC0023876 Initial
--27.07.2017: ttez Dispomerkmal 'V1' (Auto. Belieferung) aus in_art_wup_status_2 aufgenommen. Für Attribute A5, Metrik K32
--02.08.2017: ttez fix_lieferant_fg aus in_ek_orderbuch aufgenommen. Für Attribut A6, Metrik K40
--31.08.2017: ttez: Einschränkung auf BIS-relevante Artikel_2 hinzugefügt in WHERE-Bedingung

(
mandant_id
,in_art_id
,kjmo
,gjmo
,aktiv_fg
,katalog_fg
,einkauf_prueft_fg
,normalposition_fg
,anzahl
,dispo_v1_fg
,fix_lieferant_fg
)
AS

   SELECT
   a.mandant_id,
   a.in_art_id,
   b.kjmo,
   b.gjmo,
   a.aktiv_fg,
   a.katalog_fg,
   a.einkauf_prueft_fg,
   a.normalposition_fg,
   1 AS anzahl,
   CASE WHEN c.in_dispomerkmal = 'V1' THEN 1 ELSE 0 END AS dispo_v1_fg,
   COALESCE(d.fix_lieferant_fg,0) AS fix_lieferant_fg

   FROM dbp_view.v_in_art_per_2 a
   INNER JOIN dbp_view.v_monat_2 b
   ON  b.max_dat BETWEEN a.dat_von AND a.dat_bis
   LEFT JOIN
   (SELECT in_art_id,
   mandant_id,
   MAX(in_dispomerkmal) AS in_dispomerkmal FROM dbp_view.v_in_art_wup_status_2 WHERE in_dispomerkmal = 'V1' GROUP BY 1,2) c
   ON a.mandant_id = c.mandant_id AND a.in_art_id = c.in_art_id
   LEFT JOIN
   (SELECT mandant_id,
   in_art_id,
   MAX(fix_lieferant_fg) AS fix_lieferant_fg FROM dbp_view.v_in_ek_orderbuch GROUP BY 1,2 ) d
   ON a.mandant_id = d.mandant_id AND a.in_art_id = d.in_art_id

   JOIN dbp_view.v_in_art_2 e
   ON a.mandant_id = e.mandant_id AND a.in_art_id = e.in_art_id

   WHERE  (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( e.in_art_nr, 1, 1) = 'W'
   OR e.in_art_id = -1
   )

;