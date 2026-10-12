CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_ARBEITSBEREICHE
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, Erweiterung disposition_rythmus_lft_id
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
(
mandant_id
,lagerort_id
,wup_id
,nb_id
,kunde_id
,wtag_id
,dat_lief_soll
,wg_id
,arthiertyp_id
,disponent_id
,wg_verkett_id
,disposition_rhythmus_ltf_id
,terminierungsgruppe_1_id
,terminierungsgruppe_2_id
,terminierungsgruppe_3_id
,auslieferungsgruppe_id
,kunde_bez
,disposition_rhythmus_id
,disponent_name
,wup_standort
,bestellart_id
,lief_pal_typ_id
,diff_id
,menge_lief_ist_kolli
,menge_lief_soll_kolli
,betrag_lief_ist
,betrag_lief_soll
,menge_lief_palette
,mandant_id_kunde
)
AS
   SELECT
  v01.mandant_id
, v01.lagerort_id
, v01.wup_id
, v01.nb_id
, v01.kunde_id
, v01.wtag_id
, v01.dat_lief_soll
, v01.wg_id
, v01.arthiertyp_id
, v01.disponent_id
, v01.wg_verkett_id
, v01.disposition_rhythmus_ltf_id
, v01.terminierungsgruppe_1_id
, v01.terminierungsgruppe_2_id
, v01.terminierungsgruppe_3_id
, v01.auslieferungsgruppe_id
, v01.kunde_bez
, v01.disposition_rhythmus_id
, v01.disponent_name
, v01.wup_standort
, v01.bestellart_id
, Cast(v01.lief_pal_typ_id AS VARCHAR(2)) lief_pal_typ_id
, v01.diff_id
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_ist_kolli END) AS menge_lief_ist_kolli
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_soll_kolli END) AS menge_lief_soll_kolli
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.betrag_lief_ist END) AS betrag_lief_ist
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.betrag_lief_soll END) AS betrag_lief_soll
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_palette END) AS menge_lief_palette
, v01.mandant_id_kunde
   FROM dbp_view.v_besch_lief_arbeitsbereiche v01
   WHERE extract(year from v01.dat_lief_soll) >= year(current_timestamp) - 2;
