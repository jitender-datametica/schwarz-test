CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_KOSTENSTELLE_MO_SUM (
    mandant_id                          COMMENT 'Mandant im DWH'
   ,kjmo                                COMMENT 'Kalenderjahresmonat, z.Bsp 200908'
   ,kostenstelle_id                     COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400. Aktuell nur Kostenstellen vom Level 15.'
   ,anz_mo_alter_kostenstelle           COMMENT 'Age of the cost center in months. The age starts growing from the month where the first employee is assigned at this cost center, so the first one of the counts anz_mo_alter_kostenstelle_fe_i, anz_mo_alter_kostenstelle_fe_ii, anz_mo_alter_kostenstelle_fe_iii, anz_mo_alter_kostenstelle_fe_iv, anz_mo_alter_kostenstelle_fe_v, anz_mo_alter_kostenstelle_fe_vi, or anz_mo_alter_kostenstelle_me becomes 1.'
   ,anz_mo_alter_kostenstelle_fe_i      COMMENT 'The age of the cost center in months with regards to FE I employees, shr_ma_funktion_id beginn with 34 => level FE_I.'
   ,anz_mo_alter_kostenstelle_fe_ii     COMMENT 'The age of the cost center in months with regards to FE II employees, shr_ma_funktion_id beginn with 33 => level FE_II.'
   ,anz_mo_alter_kostenstelle_fe_iii    COMMENT 'The age of the cost center in months with regards to FE III employees, shr_ma_funktion_id beginn with 32 => level FE_III.'
   ,anz_mo_alter_kostenstelle_fe_iv     COMMENT 'The age of the cost center in months with regards to FE IV employees, shr_ma_funktion_id beginn with 23 => level FE_IV.'
   ,anz_mo_alter_kostenstelle_fe_v      COMMENT 'The age of the cost center in months with regards to FE V employees, shr_ma_funktion_id beginn with 22 => level FE_V.'
   ,anz_mo_alter_kostenstelle_fe_vi     COMMENT 'The age of the cost center in months with regards to FE VI employees, shr_ma_funktion_id beginn with 21 => level FE_VI.'
   ,anz_mo_alter_kostenstelle_ma        COMMENT 'The age of the cost center in months with regards to FE MA employees, shr_ma_funktion_id beginn with 1 => level MA.'
   ,anz_mo_alter_kostenstelle_gender_frau COMMENT 'The age of the cost center in months with regards to male gender employees.'
   ,anz_mo_alter_kostenstelle_gender_mann COMMENT 'The age of the cost center in months with regards to female gender employees.'
   ,anz_mo_alter_kostenstelle_bzg_00_03_mo COMMENT 'The age of the cost center in months with regards to employees who are in the company for up to 3 months (Betriebszugehörigkeit <= 3 Monate).'
   ,anz_mo_alter_kostenstelle_bzg_03_06_mo COMMENT 'The age of the cost center in months with regards to employees who are in the company for 3 to 6 months (Betriebszugehörigkeit 3-6 Monate).'
   ,anz_mo_alter_kostenstelle_bzg_06_12_mo COMMENT 'The age of the cost center in months with regards to employees who are in the company for 6 to 12 months (Betriebszugehörigkeit 6-12 Monate).'
   ,anz_mo_alter_kostenstelle_bzg_12_36_mo COMMENT 'The age of the cost center in months with regards to employees who are in the company for 12 to 36 months (or 1 to 3 years, Betriebszugehörigkeit 1-3 Jahre).'
   ,anz_mo_alter_kostenstelle_bzg_36_plus_mo COMMENT 'The age of the cost center in months with regards to employees who are in the company for more than 36 months (or more than 3 years, Betriebszugehörigkeit > 3 Jahre).'
   ,TD_UPDATE                           COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT                           COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)  COMMENT = 'SHR - monthly periodic snapshot fact table. This table stores monthly periodic snapshots of ages of cost centers. These ages are calculated in relation to the month from which the first employee was assigned to that cost center. Furthermore, the months since the first employees of certain categories (such as FE V or FE VI, male or female, etc.) are also stored.'
AS SELECT 
     mandant_id
    ,kjmo
    ,kostenstelle_id
    ,anz_mo_alter_kostenstelle
    ,anz_mo_alter_kostenstelle_fe_i
    ,anz_mo_alter_kostenstelle_fe_ii
    ,anz_mo_alter_kostenstelle_fe_iii
    ,anz_mo_alter_kostenstelle_fe_iv
    ,anz_mo_alter_kostenstelle_fe_v
    ,anz_mo_alter_kostenstelle_fe_vi
    ,anz_mo_alter_kostenstelle_ma
    ,anz_mo_alter_kostenstelle_gender_frau
    ,anz_mo_alter_kostenstelle_gender_mann
    ,anz_mo_alter_kostenstelle_bzg_00_03_mo
    ,anz_mo_alter_kostenstelle_bzg_03_06_mo
    ,anz_mo_alter_kostenstelle_bzg_06_12_mo
    ,anz_mo_alter_kostenstelle_bzg_12_36_mo
    ,anz_mo_alter_kostenstelle_bzg_36_plus_mo
    ,TD_UPDATE
    ,TD_INSERT 
FROM DBP_MSI_DATA.KOSTENSTELLE_MO_SUM ;