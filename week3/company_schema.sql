-- Week 3: COMPANY schema (ER diyagramı alıştırması)
-- Şemadaki tabloların MySQL DDL karşılığı. Altı çizili alanlar PRIMARY KEY.

CREATE DATABASE IF NOT EXISTS company;
USE company;

CREATE TABLE employee (
  fname     VARCHAR(15)   NOT NULL,
  minit     CHAR(1),
  lname     VARCHAR(15)   NOT NULL,
  ssn       CHAR(9)       NOT NULL,
  bdate     DATE,
  address   VARCHAR(50),
  sex       CHAR(1),
  salary    DECIMAL(10,2),
  superssn  CHAR(9),
  dno       INT           NOT NULL,
  PRIMARY KEY (ssn)
);

CREATE TABLE department (
  dname         VARCHAR(25) NOT NULL,
  dnumber       INT         NOT NULL,
  mgrssn        CHAR(9)     NOT NULL,
  mgrstartdate  DATE,
  PRIMARY KEY (dnumber),
  UNIQUE (dname)
);

CREATE TABLE dept_locations (
  dnumber    INT         NOT NULL,
  dlocation  VARCHAR(15) NOT NULL,
  PRIMARY KEY (dnumber, dlocation),
  FOREIGN KEY (dnumber) REFERENCES department (dnumber)
);

CREATE TABLE project (
  pname      VARCHAR(25) NOT NULL,
  pno        INT         NOT NULL,
  plocation  VARCHAR(15),
  dnum       INT         NOT NULL,
  PRIMARY KEY (pno),
  UNIQUE (pname),
  FOREIGN KEY (dnum) REFERENCES department (dnumber)
);

CREATE TABLE works_on (
  essn   CHAR(9)      NOT NULL,
  pno    INT          NOT NULL,
  hours  DECIMAL(3,1),
  PRIMARY KEY (essn, pno),
  FOREIGN KEY (essn) REFERENCES employee (ssn),
  FOREIGN KEY (pno)  REFERENCES project (pno)
);

CREATE TABLE dependent (
  essn            CHAR(9)     NOT NULL,
  dependent_name  VARCHAR(15) NOT NULL,
  sex             CHAR(1),
  bdate           DATE,
  relationship    VARCHAR(8),
  PRIMARY KEY (essn, dependent_name),
  FOREIGN KEY (essn) REFERENCES employee (ssn)
);

-- employee <-> department arasında döngüsel referans olduğu için
-- bu foreign key'ler tablolar oluştuktan sonra ekleniyor.
ALTER TABLE employee
  ADD FOREIGN KEY (superssn) REFERENCES employee (ssn),
  ADD FOREIGN KEY (dno)      REFERENCES department (dnumber);

ALTER TABLE department
  ADD FOREIGN KEY (mgrssn) REFERENCES employee (ssn);
