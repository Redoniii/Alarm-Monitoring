CREATE Database projekti;
USE projekti;

CREATE TABLE Klientet (
	ssn integer,
    emri varchar(50) not null,
    mbiemri varchar(50) not null,
    emriPrindit varchar(50),
    gjinia char(1) not null,
    dataLindjes date not null,
    adresa varchar(300 ) not null,
    tel varchar(30) not null,
    email varchar(200) not null,
    PRIMARY KEY (ssn)
);

CREATE TABLE Pozitat (
	pId integer auto_increment,
    titulli varchar(100) not null,
    paga decimal(6,2) not null,
    PRIMARY KEY (pId)
) auto_increment = 100;

CREATE TABLE Qytetet(
	qId integer not null auto_increment,
    emri varchar(20) not null,
    PRIMARY KEY (qId)
);

CREATE TABLE Menaxheret(
	mId integer auto_increment,
    emri varchar(30) not null,
    mbiemri varchar(30) not null,
    pozitaId integer not null,
    adresa varchar(200) not null,
    tel varchar(30) not null,
    email varchar(200) not null,
    qytetiId integer not null,
    PRIMARY KEY (mId),
    FOREIGN KEY (pozitaId) REFERENCES Pozitat(pId),
	FOREIGN KEY (qytetiId) REFERENCES Qytetet(qId)
) auto_increment = 10;

CREATE TABLE Llojet(
	llojiId integer auto_increment,
    lloji varchar(50) not null,
    PRIMARY KEY (llojiId)
);

CREATE TABLE Senzoret (
	sId integer auto_increment,
    emri varchar(50) not null,
    prodhuesi varchar(100) not null,
    llojiId integer not null,
    funksional boolean not null,
    dataProdhimit date not null,
    PRIMARY KEY (sId),
	FOREIGN KEY (llojiId) REFERENCES Llojet(llojiId)
) auto_increment = 1111;

CREATE TABLE Senzoret_ne_perdorim(
	senzoriId integer not null,
    klientiId integer not null,
    zona varchar(10) not null,
    PRIMARY KEY (senzoriId, klientiId),
    FOREIGN KEY (senzoriId) REFERENCES Senzoret(sId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE
);

CREATE TABLE Alarmet (
	aId char(8),
    senzoriId integer not null,
    klientiId integer not null,
    kohaAlarmit datetime not null,
    llojiAlarmit varchar(100) not null,
    pershkrimi varchar(255),
    zgjidhur boolean DEFAULT FALSE,
    kohaZgjidhjes datetime,
    PRIMARY KEY (aId),
	FOREIGN KEY (senzoriId) REFERENCES Senzoret(sId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE
);

CREATE TABLE Terminet(
	tId integer auto_increment,
    dataRegjistrimit date not null,
    dataTerminit date not null,
    klientiId integer not null,
    qytetiId integer not null,
    aktiv boolean not null,
    PRIMARY KEY (tId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE,
    FOREIGN KEY (qytetiId) REFERENCES Qytetet(qId)
) auto_increment = 6000;

CREATE TABLE Kontratat(
	kId char(8),
    klientiId integer not null,
    dataFillimit date not null,
    dataMbarimit date not null,
    PRIMARY KEY(kId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE
);

CREATE TABLE Instalimet(
    klientiId integer not null,
    dataKohaInstalimit datetime not null,
    menaxheriId integer not null,
    senzoriId integer not null,
    terminiId integer not null,
    PRIMARY KEY (klientiId, dataKohaInstalimit),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE,
    FOREIGN KEY (menaxheriId) REFERENCES Menaxheret(mId),
    FOREIGN KEY (senzoriId) REFERENCES Senzoret(sId),
    FOREIGN KEY (terminiId) REFERENCES Terminet(tId)
);

CREATE TABLE Bankat(
	bId integer auto_increment,
    emri varchar(20) not null,
    PRIMARY KEY (bId)
) auto_increment = 35;

CREATE TABLE Pagesat(
	pId integer auto_increment,
    forma varchar(10) not null,
    bankaId integer,
    dataPageses date not null,
    PRIMARY KEY (pId),
    FOREIGN KEY (bankaId) REFERENCES Bankat(bId)
);

CREATE TABLE Faturat_per_instalim(
	fiId char(7),
    klientiId integer not null,
    menaxheriId integer not null,
    cmimiPaTVSH decimal(6,2) not null,
    tvsh real not null,
    cmimiMeTVSH decimal(6,2) GENERATED ALWAYS AS (cmimiPaTVSH + (cmimiPaTVSH * TVSH)),
    dataLeshimit date not null,
    pagesaId integer,
    PRIMARY KEY (fiId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE,
    FOREIGN KEY (pagesaId) REFERENCES Pagesat(pId)
);

CREATE TABLE Faturat_per_mirembajtje(
	fmId char(7),
    klientiId integer not null,
	menaxheriId integer not null,
    cmimiPaTVSH decimal(6,2) not null,
    tvsh real not null,
    cmimiMeTVSH decimal(6,2) GENERATED ALWAYS AS (cmimiPaTVSH + (cmimiPaTVSH * TVSH)),
    dataLeshimit date not null,
    pagesaId integer,
    PRIMARY KEY (fmId),
    FOREIGN KEY (klientiId) REFERENCES Klientet(ssn) ON DELETE CASCADE,
    FOREIGN KEY (pagesaId) REFERENCES Pagesat(pId)
);

INSERT INTO Klientet
VALUES 
(444296428, 'Adnan', 'Gashi', 'Fatmir', 'M', '1977-11-18', 'Ukshin Kovaqica, Mitrovice, Kosove 40000', '049-124-466', 'adnan.gashi@gmail.com'),
(610929946, 'Atdhe', 'Bajrami', 'Armend', 'M', '1985-02-11', 'Shaban Polluzha, Mitrovice, Kosove 40000', '049-221-902', 'atdhe.bajrami@gmail.com'),
(770067064, 'Besian', 'Hoxha', 'Jeton', 'M', '1989-06-27', 'Mbreteresha Teute, Mitrovice, Kosove 40000', '044-500-600', 'besian.hoxha1@gmail.com'),
(801139531, 'Diellza', 'Hysaj', 'Ukshin', 'F', '2000-09-06', 'Iliret, Mitrovice, Kosove 40000', '049-671-909', 'diellzahysaj@gmail.com'),
(530274525, 'Gent', 'Abazi', 'Besnik', 'M', '1998-12-19', 'Musa Ademi, Gjilan, Kosove 60000', '049-126-261', 'gent_abazi@gmail.com'),
(483128182, 'Gresa', 'Latifi', 'Avni', 'F', '1987-05-21', 'Zeqir Rexhepi, Mitrovice, Kosove 40000', '045-244-677', 'gresal@gmail.com'),
(116170152, 'Iliriana', 'Hasani', 'Ermal', 'F', '1981-03-09', 'Hasan Prishtina, Prishtine, Kosove 10000', '049-199-009', 'ilirianahasani@gmail.com'),
(389846443, 'Jetmir', 'Hoxha', 'Adem', 'M', '1979-07-01', 'Sali Sejdiu, Mitrovice, Kosove 40000', '049-324-009', 'jetmirhoxha@hotmail.com'),
(132538026, 'Krenare', 'Peci', 'Flamur', 'F', '1995-11-19', 'Rexhep Kabashi, Prishtine, Kosove 10000', '049-222-333', 'krenarepeci@gmail.com'),
(826756861, 'Rilind', 'Haxhiu', 'Agim', 'M', '1997-04-12', 'Skenderbeu, Prishtine, Kosove 10000', '044-504-503', 'rilindhaxhiu1@gmail.com'),
(456328192, 'Urim', 'Shabani', 'Dukagjin', 'M', '1988-01-30', 'Haxhi Zeka, Prishtine, Kosove 10000', '049-745-892', 'urim2shabani@gmail.com');


INSERT INTO Pozitat (titulli, paga)
VALUES 
('Menaxher i Instalimeve', 1100),
('Menaxher i Pergjithshem', 2000),
('Menaxher i Financave' , 1500),
('Menaxher i Rrezikut', 1300),
('Menaxher i Teknologjise', 1600),
('Menaxher i Kontrollit', 900);

INSERT INTO Qytetet(emri)
VALUES 
('Prishtinë'),
('Mitrovicë'),
('Pejë'),
('Prizren'),
('Ferizaj'),
('Gjilan'),
('Gjakovë');
    
INSERT INTO Menaxheret(emri, mbiemri, pozitaId, adresa, tel, email, qytetiId)
VALUES
('Gresa', 'Haxha', 100, 'Ukshin Kovaqica, Mitrovice, Kosove, 40000', '049-330-222', 'gresahaxha@gmail.com', 1),
('Ilir', 'Ademi', 100, 'Shaban Polluzha, Mitrovice, Kosove, 40000', '049-330-223', 'ilirademi@gmail.com', 2),
('Arita', 'Salihu', 103, 'Mbreteresha Teute, Mitrovice, Kosove 40000', '049-330-224', 'arita.salihu@hotmail.com', 1),
('Getoar', 'Meha', 100, 'Iliret, Mitrovice, Kosove, 40000', '049-330-225', 'getoarmeha@gmail.com', 1),
('Rinor', 'Imeri', 100, 'Musa Ademi, Mitrovice, Kosove, 40000', '049-900-526', 'rinorimeri2@gmail.com', 6),
('Erjon', 'Kelmendi', 100, 'Zeqir Rexhepi, Mitrovice, Kosove, 40000', '049-330-227', 'erjon.k@gmail.com', 5),
('Fisnik', 'Haziri', 102, 'Mbreteresha Teute, Mitrovice, Kosove 40000', '049-231-330', 'fisnikh@gmail.com', 1),
('Alban', 'Baliu', 105, 'Iliret, Mitrovice, Kosove, 40000', '049-530-528', 'albanbaliiu@gmail.com', 7),
('Eliona', 'Salihu', 104, 'Musa Ademi, Mitrovice, Kosove, 40000', '049-330-229', 'elionasalihu20@gmail.com', 1),
('Redon', 'Berisha', 100, 'Zeqir Rexhepi, Mitrovice, Kosove, 40000', '049-500-230', 'redonberisha23@gmail.com', 4),
('Sejdi', 'Gashi', 101, 'Isa Boletini, Mitrovice, Kosove, 40000', '049-330-231', 'sejdigashi@gmail.com', 2);


INSERT INTO Llojet(lloji)
VALUES 
('Kamerat e vëzhgimit (CCTV)'),
('Senzor i tymit dhe zjarrit'),
('Sensori i levizjes'),
('Sensori i shtypjes'),
('Sensori i gazit'),
('Senzor per dyer dhe dritare'),
('Sensor per thyerjen e xhamit'),
('Sensor biometrik'),
('Sensor i dridhjeve'),
('Sensor infrared');


INSERT INTO Senzoret(emri, prodhuesi, llojiId, funksional, dataProdhimit)
VALUES 
('SecureView', 'Potter Electric Signal Company, LLC', 1, 1, '2022-09-22'),
('SecureView', 'Potter Electric Signal Company, LLC', 1, 0, '2023-09-22'),
('FireAlertPro', 'Figaro Engineering', 2, 1, '2022-01-31'),
('FireAlertPro', 'Figaro Engineering', 2, 1, '2023-11-13'),
('FireAlertPro', 'Figaro Engineering', 2, 1, '2023-03-19'),
('IdentityGuardian', 'STMicroelectronics', 8, 1, '2022-02-13'),
('GuardianMotion', 'STMicroelectronics', 3, 1, '2022-12-05'),
('PneumaAlert', 'STMicroelectronics', 4, 0, '2019-09-12'),
('WatchfulEye', 'Texas Instruments', 1, 1, '2022-06-13'),
('PureAir Sentinel', 'Texas Instruments', 5, 1, '2021-02-19'),
('SecureView', 'Texas Instruments', 1, 1, '2022-10-11'),
('FireAlertPro', 'Texas Instruments', 2, 1, '2023-10-18'),
('NightWatchIR', 'Vishay Intertechnology', 10, 1, '2023-10-20'),
('QuakeAlert', 'Vishay Intertechnology', 9, 1, '2023-10-20'),
('GuardianMotion', 'Vishay Intertechnology', 3, 1, '2023-02-18'),
('SecureScanPro', 'Avago Technologies', 8, 1, '2023-11-20'),
('DoorWatch', 'Avago Technologies', 6, 1, '2023-11-20'),
('ShatterSense', 'Avago Technologies', 7, 1, '2023-11-20');


INSERT INTO Senzoret_ne_perdorim
VALUES 
(1111, 444296428, 'Zona 1'),
(1112, 444296428, 'Zona 2'),
(1113, 770067064, 'Zona 1'),
(1114, 801139531, 'Zona 1'),
(1115, 530274525, 'Zona 1'),
(1116, 483128182, 'Zona 1'),
(1117, 483128182, 'Zona 3'),
(1118, 389846443, 'Zona 1'),
(1119, 389846443, 'Zona 2'),
(1120, 132538026, 'Zona 1'),
(1121, 610929946, 'Zona 1'),
(1122, 456328192, 'Zona 1'),
(1123, 826756861, 'Zona 1'),
(1124, 116170152, 'Zona 1');

INSERT INTO Alarmet
VALUES 
('A23-0001', 1111, 444296428, '2023-12-01 22:13:00', 'Mos-funksionimi i kameres', NULL, 1, '2023-12-02 09:00:00'),
('A23-0002', 1114, 801139531, '2023-12-03 14:35:00', 'Detektim i tymit', 'U zbulua tym në zonën e kuzhinës.', 1, '2023-12-03 14:50:00'),
('A23-0003', 1121, 610929946, '2023-12-04 12:15:20', 'Detektim i levizjes', NULL, 1, '2023-12-04 13:00:00'),
('A23-0004', 1116, 483128182, '2023-12-06 15:20:00', 'Tentim per qasje biometrike te paautorizuar', NULL, 1, '2023-12-06 15:40:00'),
('A23-0005', 1118, 389846443, '2023-12-07 18:45:00', 'Detektim i shtypjes se larte', 'Presion i lartë i regjistruar në zonën e prodhimit.', 1, '2023-12-07 19:15:00'),
('A23-0006', 1117, 483128182, '2023-12-07 23:15:00', 'Detektim i levizjes', NULL, 1, '2023-12-07 23:36:00'),
('A23-0007', 1120, 132538026, '2023-12-08 11:08:00', 'Rrjedhje gazi', 'U zbulua rrjedhje gazi në dhomën e shërbimeve.', 1, '2023-12-08 11:12:00'),
('A23-0008', 1123, 826756861, '2023-12-08 22:05:00', 'Detektim i levizjes permes rrezeve infrared', NULL, 1, '2023-12-08 22:20:00'),
('A23-0009', 1119, 389846443, '2023-12-10 08:35:00', 'Mos-funksionimi i kameres', NULL, 1, '2023-12-10 09:05:00'),
('A23-0010', 1124, 116170152, '2023-12-11 22:49:00', 'Dridhje te pazankonta', NULL, 0, NULL);

INSERT INTO Terminet(dataRegjistrimit, dataTerminit, klientiId, qytetiId, aktiv)
VALUES
('2023-11-10', '2023-11-16', 116170152, 1, 1),
('2023-11-14', '2023-11-18', 801139531, 2, 1),
('2023-11-15', '2023-11-18', 444296428, 2, 1),
('2023-11-15', '2023-11-19', 770067064, 2, 0),
('2023-11-16', '2023-11-19', 610929946, 2, 1),
('2023-11-17', '2023-11-20', 456328192, 1, 1),
('2023-11-17', '2023-11-20', 483128182, 2, 1),
('2023-11-18', '2023-11-20', 116170152, 2, 1),
('2023-11-19', '2023-11-21', 389846443, 2, 0),
('2023-11-19', '2023-11-21', 132538026, 1, 1),
('2023-11-20', '2023-11-21', 826756861, 1, 1),
('2023-11-20', '2023-11-21', 530274525, 1, 1);

INSERT INTO Kontratat
VALUES 
('AB1CD23E', 444296428, '2023-01-01', '2024-01-01'),
('4FGH56IJ', 770067064, '2023-10-10', '2024-10-10'),
('KLM7NO8P', 610929946, '2023-01-01', '2024-01-01'),
('9QRSTU0V', 801139531, '2023-01-01', '2024-01-01'),
('WXYZ12AB', 530274525, '2023-08-05', '2024-08-05'),
('3CDEFG45', 483128182, '2023-10-20', '2024-10-20'),
('678HIJKL', 116170152, '2022-01-01', '2024-01-01'),
('MNOPQ90R', 389846443, '2023-09-01', '2024-09-01'),
('STUV1WXY', 132538026, '2023-09-01', '2024-09-01'),
('Z23ABCDE', 826756861, '2023-11-15', '2024-11-15'),
('FGHIJ4KL', 456328192, '2023-09-09', '2024-09-09');

INSERT INTO Instalimet
VALUES 
(116170152, '2023-11-16 10:00:00', 10, 1124, 6000),
(801139531, '2023-11-18 10:00:00', 11, 1114, 6001),
(444296428, '2023-11-18 11:30:00', 11, 1111, 6002),
(770067064, '2023-11-19 10:00:00', 11, 1113, 6003),
(610929946, '2023-11-19 11:00:00', 11, 1121, 6004),
(483128182, '2023-11-20 11:00:00', 11, 1116, 6006),
(456328192, '2023-11-20 10:00:00', 10, 1122, 6005),
(389846443, '2023-11-21 10:00:00', 13, 1119, 6008),
(132538026, '2023-11-21 13:00:00', 13, 1120, 6009),
(826756861, '2023-11-21 10:00:00', 10, 1123, 6010),
(530274525, '2023-11-21 14:00:00', 14, 1115, 6011);

INSERT INTO Bankat(emri)
VALUES 
('RBKO'),
('NLB'),
('TEB'),
('BKT'),
('PCB'),
('BE'),
('BPB');

INSERT INTO Pagesat 
VALUES 
(1, 'Kesh', NULL, '2023-11-16'),
(2, 'Banke', 35, '2023-11-20'),
(3, 'Banke', 35, '2023-11-19'),
(4, 'Banke', 39, '2023-11-19'),
(5, 'Kesh', NULL, '2023-11-21'),
(6, 'Banke', 40, '2023-11-22'),
(7, 'Banke', 36, '2023-11-21'),
(8, 'Banke', 36, '2023-11-21'),
(9, 'Kesh', NULL, '2023-11-25'),
(10, 'Banke', 37, '2023-11-26'),
(11, 'Banke', 40, '2023-11-15'),
(12, 'Banke', 35, '2023-11-15'),
(13, 'Banke', 35, '2023-11-12'),
(14, 'Banke', 41, '2023-11-14'),
(15, 'Kesh', NULL, '2023-11-18'),
(16, 'Kesh', NULL, '2023-11-17'),
(17, 'Banke', 36, '2023-11-20'),
(18, 'Banke', 37, '2023-11-21'),
(19, 'Banke', 40, '2023-11-27');

INSERT INTO Faturat_per_instalim(fiId, klientiId, menaxheriId, cmimiPaTVSH, tvsh, dataLeshimit, pagesaId)
VALUES
('FI-0001', 116170152, 10, 100, 0.18, '2023-11-16', 1),
('FI-0002', 801139531, 11, 100, 0.18, '2023-11-18', 2),
('FI-0003', 444296428, 11, 300, 0.18, '2023-11-18', 3),
('FI-0004', 770067064, 11, 80, 0.18, '2023-11-19', 4),
('FI-0005', 610929946, 11, 120, 0.18, '2023-11-19', 5),
('FI-0006', 483128182, 11, 200, 0.18, '2023-11-20', 6),
('FI-0007', 456328192, 13, 300, 0.18, '2023-11-20', NULL),
('FI-0008', 132538026, 10, 50, 0.18, '2023-11-21', 7),
('FI-0009', 132538026, 10, 50, 0.18, '2023-11-21', 8),
('FI-0010', 826756861, 13, 100, 0.18, '2023-11-21', 9),
('FI-0011', 530274525, 14,250, 0.18, '2023-11-21', 10);


INSERT INTO Faturat_per_mirembajtje(fmId, klientiId, menaxheriId,cmimiPaTVSH, tvsh, dataLeshimit, pagesaId)
VALUES
('FM-0001', 444296428, 11, 50, 0.18, '2023-11-10', 11),
('FM-0002', 610929946, 11, 50, 0.18, '2023-11-10', 12),
('FM-0003', 770067064, 11, 75, 0.18, '2023-11-12', 13),
('FM-0004', 801139531, 11, 120, 0.18, '2023-11-12', 14),
('FM-0005', 530274525, 14, 30, 0.18, '2023-11-12', NULL),
('FM-0006', 483128182, 20, 150, 0.18, '2023-11-14', 19),
('FM-0007', 116170152, 10, 50, 0.18, '2023-11-16', 15),
('FM-0008', 389846443, 11, 75, 0.18, '2023-11-16', 16),
('FM-0009', 132538026, 13, 120, 0.18, '2023-11-16', NULL),
('FM-0010', 826756861, 13, 75, 0.18, '2023-11-18', 17),
('FM-0011', 456328192, 10, 30, 0.18, '2023-11-18', 18);

-- 1
SELECT Senzoret.*
FROM Senzoret
LEFT JOIN Senzoret_ne_perdorim ON sId = senzoriId
WHERE senzoriId IS NULL;

-- 2
SELECT ssn, emri, mbiemri, SUM(fi.cmimiMeTVSH) fatura_per_instalim_te_paguara, SUM(fm.cmimiMeTVSH) fatura_per_mirembajtje_te_paguara
FROM Klientet k
INNER JOIN Faturat_per_instalim fi ON fi.klientiId = ssn AND fi.pagesaId IS NOT NULL
INNER JOIN Faturat_per_mirembajtje fm ON fm.klientiId = ssn AND fm.pagesaId IS NOT NULL
GROUP BY ssn
HAVING (fatura_per_instalim_te_paguara > 200) AND (fatura_per_mirembajtje_te_paguara > 110);

-- 3
SELECT * 
FROM Terminet 
WHERE qytetiId = 1 AND dataTerminit = '2023-11-21';

-- 4
SELECT DISTINCT mId
FROM Menaxheret 
INNER JOIN Instalimet i ON mId = i.menaxheriId
WHERE (SELECT Count(*) FROM Instalimet i WHERE i.menaxheriId = mId AND DATE(i.dataKohaInstalimit) = '2023-11-21') > 1 
AND (SELECT Count(*) FROM Instalimet i WHERE i.menaxheriId = mId AND DATE(i.dataKohaInstalimit) = '2023-11-22') = 0;

-- 5
SELECT m.miD, m.emri, m.mbiemri, q.emri qyteti ,count(*) AS instalime_3_muajt_e_fundit
FROM Menaxheret m
INNER JOIN Instalimet i ON m.mId = i.menaxheriId
INNER JOIN Qytetet q on m.qytetiId = q.qId
WHERE DATE(dataKohaInstalimit) > '2023-11-01'
GROUP BY mId
ORDER BY instalime_3_muajt_e_fundit DESC
LIMIT 5;

-- 6
SELECT 
	q.qId ,
    q.emri AS Qyteti,
    COUNT(DISTINCT m.mId) AS NumriMenaxhereve,
    COALESCE(NumriInstalimeve, 0) AS NumriInstalimeve,
    COALESCE(NumriMirembajtjeve, 0) AS NumriMirembajtjeve,
    (COALESCE(ShumaInstalimeve, 0) + COALESCE(ShumaMirembajtjeve, 0)) AS totaliPaTVSH,
	(COALESCE(ShumaInstalimeveTVSH, 0) + COALESCE(ShumaMirembajtjeveTVSH, 0)) AS totaliMeTVSH,
    (COALESCE(paguarFI, 0) + COALESCE(paguarFM, 0)) AS totaliPaguar
FROM 
    Qytetet q
LEFT JOIN 
    Menaxheret m ON q.qId = m.qytetiId
LEFT JOIN (
    SELECT 
        m.qytetiId,
        COUNT(DISTINCT fi.fiId) AS NumriInstalimeve,
        SUM(fi.cmimiPaTVSH) AS ShumaInstalimeve,
        SUM(fi.cmimiMeTVSH) as ShumaInstalimeveTVSH
    FROM 
        Menaxheret m
    LEFT JOIN 
        Faturat_per_instalim fi ON m.mId = fi.menaxheriId AND YEAR(fi.dataLeshimit) = 2023
    GROUP BY 
        m.qytetiId
) AS FaturatInstalim ON q.qId = FaturatInstalim.qytetiId
LEFT JOIN (
    SELECT 
        m.qytetiId,
        COUNT(DISTINCT fm.fmId) AS NumriMirembajtjeve,
        SUM(fm.cmimiPaTVSH) AS ShumaMirembajtjeve,
        SUM(fm.cmimiMeTVSH) as ShumaMirembajtjeveTVSH
    FROM 
        Menaxheret m
    LEFT JOIN 
        Faturat_per_mirembajtje fm ON m.mId = fm.menaxheriId AND YEAR(fm.dataLeshimit) = 2023
    GROUP BY 
        m.qytetiId
) AS FaturatMirembajtje ON q.qId = FaturatMirembajtje.qytetiId

LEFT JOIN (
    SELECT 
        m.qytetiId,
        SUM(fi.cmimiMeTVSH) as paguarFI
    FROM 
        Menaxheret m
    LEFT JOIN 
        Faturat_per_instalim fi ON m.mId = fi.menaxheriId AND YEAR(fi.dataLeshimit) = 2023 AND fi.pagesaId is not null
    GROUP BY 
        m.qytetiId
) AS PagesatFI ON q.qId = PagesatFI.qytetiId

LEFT JOIN (
    SELECT 
        m.qytetiId,
        SUM(fm.cmimiMeTVSH) as paguarFM
    FROM 
        Menaxheret m
    LEFT JOIN 
        Faturat_per_mirembajtje fm ON m.mId = fm.menaxheriId AND YEAR(fm.dataLeshimit) = 2023 AND fm.pagesaId is not null		
    GROUP BY 
        m.qytetiId
) AS PagesatFM ON q.qId = PagesatFM.qytetiId
GROUP BY 
    q.emri, q.qId
ORDER BY 
    q.qId;

select * from pagesat;
