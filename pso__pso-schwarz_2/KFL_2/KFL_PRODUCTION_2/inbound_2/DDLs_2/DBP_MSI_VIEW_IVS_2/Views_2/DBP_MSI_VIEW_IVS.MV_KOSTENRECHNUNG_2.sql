CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KOSTENRECHNUNG_2 as
           -- 2008-12-15
           -- FAKTVIEW Kostenrechnung_2 KER
           -- Kurstyp 3 ergänzt

           SELECT
           mandant_id,
           pc_id,
           kj_ker_mo_id,
           kostenart_id,
           plan_fg,
           planvariante_id,
           kostenrechnung_betrag * umrechnungskurs AS euro_betrag,
           umrechnungskurs,
           kostenrechnung_betrag,
           wrg_id,
           system_id,
           krk_id,
           buchungskreis_id_ker,
           gj,
           buchungsperiode_id

 FROM dbp_view.v_kostenrechnung_2  kr
           INNER JOIN
           (
           SELECT von_wrg_id,
           umrechnungskurs
 FROM dbp_view.v_kurs_2 u
           WHERE kurstyp_id = 3 AND dat_bis = '9999-12-31'
           ) ku
           ON kr.wrg_id = ku.von_wrg_id;