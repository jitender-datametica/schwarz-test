CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HFM_INVENTUR_TERMIN
AS
   -- FAKT : Inventuren nach Inventurart + Umsatz pro Filiale und WG
   -- Datenbasis HFM Inventur + VIS Umsatz
   -- 2017.0620 : Initial, VTC Inventur
   -- 2017.0815 : Update, Outer Join Umsatz
   -- 2017.1211 : Update Zwischen-Jahresinventur (inv_inv_fg)
   -- 2018.0102 : Right Outer statt Left Outer zwischen vis und hfm + COALESCE bei Join-Spalten + inventurart_int_id = 8 THEN -1 korrigiert
   -- 2018.0528 : Review. right join durch select ersetzt + umsatz abteilung ergaenzt

   SELECT
   hfm.mandant_id, hfm.nb_id, hfm.wup_id, hfm.gj, hfm.wg_id, hwg.hwg_id, abt.abt_id, hfm.inventurart_int_id, hfm.inventurart_int_id * 100 + hwg.hwg_id::INTEGER AS inventurart_hwg_id, hfm.dat_plan_zaehlung, hfm.dat_vorletzte_zaehlung, hfm.zeitraum, hfm.wrg_id, hfm.wert_netto_inventur, hfm.ums_netto_inventur, hfm.ums_netto_wg, hfm.ums_netto_abt, hfm.inv_fg, hfm.inv_inv AS inv_inv_fg
   FROM (
   SELECT
   inv.mandant_id, inv.nb_id, inv.wup_id, inv.wg_id, inv.inventurart_int_id, inv.dat_plan_zaehlung, inv.dat_vorletzte_zaehlung, to_number(inv.dat_plan_zaehlung - inv.dat_vorletzte_zaehlung,38,0) AS zeitraum, zeit.gj, inv.wrg_id, inv.inventur_wert_vk_netto AS wert_netto_inventur, inv.umsatz_vk_netto_sum    AS ums_netto_inventur, inv.inv_inv, 1::BYTEINT AS inv_fg, SUM(vis.ums_netto)         AS ums_netto_wg, SUM(vis.ums_netto_abt)     AS ums_netto_abt
   FROM (
   SELECT -- 1. Landeswaehrung
   inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id, inv0.inventurart_int_id, inv0.dat_plan_zaehlung, inv0.dat_vorletzte_zaehlung, inv0.wrg_id, inv0.inventur_wert_vk_netto, inv0.umsatz_vk_netto_sum, MAX(CASE WHEN inv0.inventurart_int_id IN (4,5) THEN dat_plan_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id)  dat_inv_aktuell, MIN(CASE WHEN inv0.inventurart_int_id IN (4,5) THEN dat_vorletzte_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id) dat_inv_vorher, MAX(CASE WHEN inv0.inventurart_int_id IN (3) THEN dat_plan_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id)  dat_inv_aktuell_wg, MIN(CASE WHEN inv0.inventurart_int_id IN (3) THEN dat_vorletzte_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id) dat_inv_vorher_wg, CASE
   WHEN inventurart_int_id = 8 THEN -1                                       -- Historie GJ
   WHEN dat_inv_aktuell IS NULL AND dat_inv_aktuell_wg IS NULL THEN 1        -- noch keine Zwischen-/Jahres und WG-Inventur
   WHEN dat_plan_zaehlung = dat_inv_aktuell THEN 1                           -- letzte Zwischen-/Jahres-Inventur
   WHEN dat_plan_zaehlung BETWEEN dat_inv_vorher AND dat_inv_aktuell THEN 0  -- alle Inventuren (inkl. WG) vor letzter Zwischen-/Jahres-Inventur
   WHEN inventurart_int_id = 3 THEN 1                                        -- alle WG-Inventuren
   WHEN inventurart_int_id IN (1, 2) AND dat_plan_zaehlung BETWEEN dat_inv_vorher_wg AND dat_inv_aktuell_wg THEN 0 -- Alle Flop-/Sonder-Inventuren vor WG-Inventur
   ELSE 1 -- noch keine Zwischen-/Jahres-Inventur/WG-Inventur oder Inventur nach letzter Zwischen-/Jahres-Inventur/WG-Inventur
   END::BYTEINT AS inv_inv
   FROM dbp_view.v_hfm_inventur_termin_wg_wup_zu_per inv0

   UNION ALL
   SELECT  -- 2. Umrechnung in EUR
   inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id, inv0.inventurart_int_id, inv0.dat_plan_zaehlung, inv0.dat_vorletzte_zaehlung, kurs0.nach_wrg_id AS wrg_id, inv0.inventur_wert_vk_netto * kurs0.umrechnungskurs AS inventur_wert_vk_netto, inv0.umsatz_vk_netto_sum * kurs0.umrechnungskurs AS umsatz_vk_netto_sum, MAX(CASE WHEN inv0.inventurart_int_id IN (4,5) THEN dat_plan_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id)  dat_inv_aktuell, MIN(CASE WHEN inv0.inventurart_int_id IN (4,5) THEN dat_vorletzte_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id) dat_inv_vorher, MAX(CASE WHEN inv0.inventurart_int_id IN (3) THEN dat_plan_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id)  dat_inv_aktuell_wg, MIN(CASE WHEN inv0.inventurart_int_id IN (3) THEN dat_vorletzte_zaehlung end) OVER (PARTITION BY inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id) dat_inv_vorher_wg, CASE
   WHEN inventurart_int_id = 8 THEN -1                                       -- Historie GJ
   WHEN dat_inv_aktuell IS NULL AND dat_inv_aktuell_wg IS NULL THEN 1        -- noch keine Zwischen-/Jahres und WG-Inventur
   WHEN dat_plan_zaehlung = dat_inv_aktuell THEN 1                           -- letzte Zwischen-/Jahres-Inventur
   WHEN dat_plan_zaehlung BETWEEN dat_inv_vorher AND dat_inv_aktuell THEN 0  -- alle Inventuren (inkl. WG) vor letzter Zwischen-/Jahres-Inventur
   WHEN inventurart_int_id = 3 THEN 1                                        -- alle WG-Inventuren
   WHEN inventurart_int_id IN (1, 2) AND dat_plan_zaehlung BETWEEN dat_inv_vorher_wg AND dat_inv_aktuell_wg THEN 0 -- Alle Flop-/Sonder-Inventuren vor WG-Inventur

   ELSE 1 -- noch keine Zwischen-/Jahres-Inventur/WG-Inventur oder Inventur nach letzter Zwischen-/Jahres-Inventur/WG-Inventur
   END::BYTEINT inv_inv
   FROM dbp_view.v_hfm_inventur_termin_wg_wup_zu_per inv0

   JOIN dbp_view.v_mandant man0
   ON man0.mandant_id = inv0.mandant_id AND man0.default_wrg <> 'EUR'

   JOIN dbp_view.v_kurs kurs0
   ON kurs0.von_wrg_id = inv0.wrg_id AND kurs0.kurstyp_id = 3 AND kurs0.dat_bis = '9999-12-31'
   ) inv

   JOIN dbp_view.v_tag zeit
   ON zeit.dat = inv.dat_plan_zaehlung
   LEFT JOIN ( -- umsatz im Zeitraum der Inventur pro WG + Abteilung
   SELECT
   vis0.mandant_id, vis0.nb_id, vis0.wup_id, wg0.abt_id, vis0.wg_id, vis0.wrg_id, vis0.dat, vis0.ums_netto, SUM(vis0.ums_netto) OVER (PARTITION BY vis0.mandant_id, vis0.wup_id, wg0.abt_id, vis0.wrg_id, vis0.dat ORDER BY vis0.mandant_id, vis0.wup_id, wg0.abt_id, vis0.wg_id, vis0.wrg_id, vis0.dat) ums_netto_abt
   FROM dbp_msi_v_view.v_vis_tag_umsatz_wg vis0

   JOIN dbp_view.v_tag zeit
   ON zeit.dat = vis0.dat AND zeit.akt_gj BETWEEN -1 AND 0

   JOIN dbp_view.v_wg_per wg0
   ON wg0.wg_id = vis0.wg_id AND wg0.mandant_id = vis0.mandant_id
   AND wg0.arthiertyp_id = 2 AND wg0.dat_bis='9999-12-31'
   ) vis
   ON vis.mandant_id = inv.mandant_id AND vis.wup_id = inv.wup_id AND vis.wg_id = inv.wg_id AND vis.wrg_id = inv.wrg_id
   AND vis.dat BETWEEN inv.dat_vorletzte_zaehlung AND inv.dat_plan_zaehlung

   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
   ) hfm

   JOIN dbp_msi_view_vis.mv_wg_hwg_zu hwg
   ON hwg.mandant_id = hfm.mandant_id AND hwg.wg_id = hfm.wg_id

   JOIN dbp_msi_view_vis.mv_hwg_abt_zu abt
   ON abt.mandant_id = hwg.mandant_id AND abt.hwg_id = hwg.hwg_id
   ;