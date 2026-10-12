CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ANZEIGE_MENGE_EINH_2 as
   select * from (select 'BME' as anzeige_menge_einh_id, 'Basismengeneinheit (ST oder KG)' as anzeige_menge_einh_bez ) bme union
   select * from (select 'ST' as anzeige_menge_einh_id, 'Stück' as anzeige_menge_einh_bez) st union
   select * from (select 'KG' as anzeige_menge_einh_id, 'Kilogramm' as anzeige_menge_einh_bez ) kg union
   select * from (select 'EUR' as anzeige_menge_einh_id, 'VK_2-Brutto' as anzeige_menge_einh_bez ) eur union
   select * from (select 'KOL' as anzeige_menge_einh_id, 'Kolli' as anzeige_menge_einh_bez ) kol;