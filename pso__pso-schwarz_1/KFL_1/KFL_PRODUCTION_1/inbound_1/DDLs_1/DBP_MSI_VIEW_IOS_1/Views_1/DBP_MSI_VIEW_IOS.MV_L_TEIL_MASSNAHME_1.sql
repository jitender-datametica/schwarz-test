CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_TEIL_MASSNAHME_1 as
   -- 20081217: teil_massnahme_id aus v_cpr_phase_per_1 mit group by
   -- 20081217: Aktuellster Satz durch " dat_bis = '9999-12-31' " Einschränkung

   
SELECT teil_massnahme_id
FROM dbp_view.v_cpr_phase_per_1
where dat_bis = '9999-12-31'
Group by teil_massnahme_id;