--[OK] statement is translated correctly (syntax and type checks are fine)
select  mandant_id, bewertungskreis_id, buchungskreis_id  from DBP_DATA.l_bewertungskreis_2 group by 1,2,3;

