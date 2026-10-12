CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_kostenstelle_mo_sum_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), kjmo OPTIONS(description='Kalenderjahresmonat, z.Bsp 200908'), kostenstelle_id
OPTIONS(description='ID der Kostenstelle, z.Bsp. 9676-400. Aktuell nur Kostenstellen vom Level 15.'),
anz_mo_alter_kostenstelle
OPTIONS(description='Age of the cost center in months. The age starts growing from the month where the first employee_2 is assigned at this cost center, so the first one of the counts anz_mo_alter_kostenstelle_fe_i, anz_mo_alter_kostenstelle_fe_ii, anz_mo_alter_kostenstelle_fe_iii, anz_mo_alter_kostenstelle_fe_iv, anz_mo_alter_kostenstelle_fe_v, anz_mo_alter_kostenstelle_fe_vi, or anz_mo_alter_kostenstelle_me becomes 1.'),
anz_mo_alter_kostenstelle_fe_i
OPTIONS(description='The age of the cost center in months with regards to FE I employees, shr_ma_funktion_id beginn with 34 => level FE_I.'),
anz_mo_alter_kostenstelle_fe_ii
OPTIONS(description='The age of the cost center in months with regards to FE II employees, shr_ma_funktion_id beginn with 33 => level FE_II.'),
anz_mo_alter_kostenstelle_fe_iii
OPTIONS(description='The age of the cost center in months with regards to FE III employees, shr_ma_funktion_id beginn with 32 => level FE_III.'),
anz_mo_alter_kostenstelle_fe_iv
OPTIONS(description='The age of the cost center in months with regards to FE IV employees, shr_ma_funktion_id beginn with 23 => level FE_IV.'),
anz_mo_alter_kostenstelle_fe_v
OPTIONS(description='The age of the cost center in months with regards to FE V employees, shr_ma_funktion_id beginn with 22 => level FE_V.'),
anz_mo_alter_kostenstelle_fe_vi
OPTIONS(description='The age of the cost center in months with regards to FE VI employees, shr_ma_funktion_id beginn with 21 => level FE_VI.'),
anz_mo_alter_kostenstelle_ma
OPTIONS(description='The age of the cost center in months with regards to FE MA employees, shr_ma_funktion_id beginn with 1 => level MA.'),
anz_mo_alter_kostenstelle_gender_frau
OPTIONS(description='The age of the cost center in months with regards to male gender employees.'),
anz_mo_alter_kostenstelle_gender_mann
OPTIONS(description='The age of the cost center in months with regards to female gender employees.'),
anz_mo_alter_kostenstelle_bzg_00_03_mo
OPTIONS(description='The age of the cost center in months with regards to employees who are in the company for up to 3 months (Betriebszugehörigkeit <= 3 Monate).'),
anz_mo_alter_kostenstelle_bzg_03_06_mo
OPTIONS(description='The age of the cost center in months with regards to employees who are in the company for 3 to 6 months (Betriebszugehörigkeit 3-6 Monate).'),
anz_mo_alter_kostenstelle_bzg_06_12_mo
OPTIONS(description='The age of the cost center in months with regards to employees who are in the company for 6 to 12 months (Betriebszugehörigkeit 6-12 Monate).'),
anz_mo_alter_kostenstelle_bzg_12_36_mo
OPTIONS(description='The age of the cost center in months with regards to employees who are in the company for 12 to 36 months (or 1 to 3 years, Betriebszugehörigkeit 1-3 Jahre).'),
anz_mo_alter_kostenstelle_bzg_36_plus_mo
OPTIONS(description='The age of the cost center in months with regards to employees who are in the company for more than 36 months (or more than 3 years, Betriebszugehörigkeit > 3 Jahre).'),
td_update
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'))
OPTIONS(DESCRIPTION = `SHR - MONTHLY PERIODIC SNAPSHOT_2 FACT TABLE. THIS TABLE STORES MONTHLY PERIODIC SNAPSHOTS OF AGES OF COST CENTERS. THESE AGES ARE CALCULATED IN RELATION TO THE MONTH FROM WHICH THE FIRST EMPLOYEE_2 WAS ASSIGNED TO THAT COST CENTER. FURTHERMORE, THE MONTHS SINCE THE FIRST EMPLOYEES OF CERTAIN CATEGORIES (SUCH AS FE V OR FE VI, MALE OR FEMALE, ETC.) ARE ALSO STORED.`)
AS SELECT mandant_id,
 kjmo,
 kostenstelle_id,
 anz_mo_alter_kostenstelle,
 anz_mo_alter_kostenstelle_fe_i,
 anz_mo_alter_kostenstelle_fe_ii,
 anz_mo_alter_kostenstelle_fe_iii,
 anz_mo_alter_kostenstelle_fe_iv,
 anz_mo_alter_kostenstelle_fe_v,
 anz_mo_alter_kostenstelle_fe_vi,
 anz_mo_alter_kostenstelle_ma,
 anz_mo_alter_kostenstelle_gender_frau,
 anz_mo_alter_kostenstelle_gender_mann,
 anz_mo_alter_kostenstelle_bzg_00_03_mo,
 anz_mo_alter_kostenstelle_bzg_03_06_mo,
 anz_mo_alter_kostenstelle_bzg_06_12_mo,
 anz_mo_alter_kostenstelle_bzg_12_36_mo,
 anz_mo_alter_kostenstelle_bzg_36_plus_mo,
 td_update,
 td_insert
FROM kfl_production_dbp_msi_data.kostenstelle_mo_sum_2;