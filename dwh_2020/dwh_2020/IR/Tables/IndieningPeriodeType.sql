﻿CREATE TABLE [IR].[IndieningPeriodeType] (
    [IndieningPeriodeTypeID] NVARCHAR (15)  NOT NULL,
    [Description]            NVARCHAR (50)  NOT NULL,
    [DependencySet]          NVARCHAR (200) NULL,
    [SortOrder]              INT            NULL,
    [Comment]                NVARCHAR (800) NULL,
    [SoftDeleted]            BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningPeriodeType] PRIMARY KEY CLUSTERED ([IndieningPeriodeTypeID] ASC)
);

