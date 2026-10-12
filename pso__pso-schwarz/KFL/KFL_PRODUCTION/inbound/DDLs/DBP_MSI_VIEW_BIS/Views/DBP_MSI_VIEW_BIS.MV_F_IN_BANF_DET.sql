CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_BANF_DET
-- 23.06.2017 ttez: SPEC0023876 Initial
-- 28.06.2017 ttez: dat_banf_beleg aufgenommen
-- 08.12.2017 twie: Filter aus Bestellungen (besch_best_det) übernommen, damit Werte vergleichbar sind

(
mandant_id
,banf_beleg_id
,banf_beleg_pos_id
,in_belegart_id
,status_id
,freigabe_zustand_kz
,in_art_id
,werk_id
,best_beleg_id
,best_beleg_pos_id
,dat_best_beleg
,automatisch_fg
,freitext_fg
,dat_banf_beleg
)
AS
   SELECT
   v01.mandant_id,
   v01.banf_beleg_id,
   v01.banf_beleg_pos_id,
   v01.in_belegart_id,
   v01.status_id,
   v01.freigabe_zustand_kz,
   v01.in_art_id,
   v01.werk_id,
   v01.best_beleg_id,
   v01.best_beleg_pos_id,
   v01.dat_best_beleg,
   v01.automatisch_fg,
   v01.freitext_fg,
   v02.dat_banf_beleg
   FROM dbp_view.v_in_banf_det v01

   JOIN dbp_view.v_in_banf v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.banf_beleg_id = v02.banf_beleg_id

   JOIN dbp_view.v_in_besch_best v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.best_beleg_id = v03.best_beleg_id

   WHERE v01.best_beleg_id > 0  -- Bestellanforderungen mit Bestellung

   AND  v03. memory_fg = 0

   --Einschränkung auf relevante Lieferanten
   AND (v03.mandant_id, v03.in_lief_id) IN
   (
   SELECT
   v11.mandant_id,
   v11.in_lief_id
   FROM dbp_view.v_in_lieferant_ekorg_zu v11
   INNER JOIN dbp_view.v_in_l_ekorg v12
   ON v11.mandant_id = v12.mandant_id
   AND v11.einkaufsorganisation_id = v12.einkaufsorganisation_id
   AND v12.sako_fg = 1
   AND v11.einkaeufer_grp_id IS NOT NULL
   )

   --Einschränkung auf relevante Buchungskreise
   AND (v03.mandant_id, v03.buchungskreis_id) IN
   (
   SELECT
   mandant_id,
   buchungskreis_id
   FROM dbp_view.v_in_l_buchungskreis
   WHERE sako_fg = 1
   )

/* --benötigt?
-- nur Umsätze auf relevanten Artikeln reporten, analog Artikellookup
AND (v06.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
OR v06.in_art_nr LIKE 'W%'
OR v06.in_art_id = -1
)

--gelöschte Bestellungen ausschließen
AND v02.loesch_id = ''
*/
;