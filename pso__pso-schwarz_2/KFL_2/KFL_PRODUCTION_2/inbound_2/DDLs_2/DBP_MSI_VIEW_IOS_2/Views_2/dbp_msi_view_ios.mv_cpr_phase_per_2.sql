CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_cpr_phase_per_2
-- 20160511 k.kaiser: SPEC0009788, bauabschnitte aus der cpr_aufgabe_per_2 werden auch mitberücksichtigt, wenn cpr_suchfeld_id 161 (= cpr_suchfeld_bez = 'CPR_REALISIERUNG')
--                                                                 und aufgabenart_id in ('A2','Z1')
AS
SELECT
ph.projekt_phase_id
,ph.projekt_id
,pr.cpr_ext_id   AS projekt_nr
,ph.cpr_ext_id   AS phase_nr
,ph.phasenart_id
,CAST(NULL AS VARCHAR(40))     AS cpr_phase_gruppe_id
,ph.dat_freigabe
,c.cpr_suchfeld AS cpr_suchfeld
,ph.teil_massn_kz AS teil_massn_fg

-- neu für Bauabschnitt in der Phasen-VIEW

, bas.bauabschnitt_id
, bas.bauabschnitt_bez
, bas.bauabschnitt_langtext
, bas.bauabschnitt_abgelaufen_fg
-- ALIAS für lfd_nr
, SUBSTRING(bas.bauabschnitt_id, 33, 4)  AS bauabschnitt_nr

-- neu bis hier

,ph.einzel_massnahme
,ph.teil_massnahme_id
,ph.cpr_systemstatus1_id
,ph.cpr_systemstatus2_id
,ph.cpr_systemstatus3_id
,pr.mandant_id
,t.dat  AS dat_von
,CASE WHEN t.dat = CURRENT_DATE() THEN  TO_DATE('9999-12-31') ELSE t.dat  END AS dat_bis
, '  ' AS aufgabenart_id

FROM dbp_view.v_cpr_phase_per_2    ph

JOIN dbp_view.v_tag_2 t
on t.dat between ph.dat_von and ph.dat_bis
and t.dat <= CURRENT_DATE()
AND t.dat BETWEEN CURRENT_DATE() - 14 AND CURRENT_DATE()

JOIN dbp_view.v_cpr_projekt_per_2   pr
ON   ph.projekt_id = pr.projekt_id
AND t.dat BETWEEN  pr.dat_von AND pr.dat_bis

LEFT JOIN dbp_view.v_cpr_aufgabe_per_2  au
ON   ph.projekt_phase_id = au.projekt_phase_id
AND  t.dat BETWEEN  au.dat_von AND au.dat_bis

LEFT JOIN
dbp_view.v_l_cpr_suchfeld_2 c
ON ph.cpr_suchfeld_id = c.cpr_suchfeld_id

LEFT JOIN (Select
projekt_nr
,bauabschnitt_id
,bauabschnitt_nr
,bauabschnitt_bez
,bauabschnitt_langtext
,bauabschnitt_abgelaufen_fg
from
dbp_msi_view_ios.mv_projekt_bauabschnitt_2 bas

group by 1,2,3,4,5,6) bas
ON pr.cpr_ext_id = bas.projekt_nr;
