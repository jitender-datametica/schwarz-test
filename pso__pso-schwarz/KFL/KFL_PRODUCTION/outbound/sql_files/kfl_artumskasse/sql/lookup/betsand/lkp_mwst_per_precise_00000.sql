--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    A.mandant_id,
    A.mwst_id,
    B.dat,
    A.mwst,
    A.sap_mwst_id,
    A.dat_von,
    A.dat_bis
FROM dbp_data.mwst_per AS A
INNER JOIN dbp_data.tag AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis;
