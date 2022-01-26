CREATE TABLE [IR].[IndieningTypeVersieRole] (
    [IndieningTypeVersieRoleID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningTypeVersieID]     NVARCHAR (15) NOT NULL,
    [RoleName]                  NVARCHAR (50) NOT NULL,
    [DatumVan]                  DATETIME      NULL,
    [DatumTot]                  DATETIME      NULL,
    [AantalJaarZichtbaar]       INT           NULL,
    [StartJaar]                 INT           NULL,
    [SoftDeleted]               BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION    NOT NULL,
    CONSTRAINT [PK_IndieningTypeVersieRole] PRIMARY KEY CLUSTERED ([IndieningTypeVersieRoleID] ASC),
    CONSTRAINT [FK_IndieningTypeVersieRole_IndieningTypeVersie] FOREIGN KEY ([IndieningTypeVersieID]) REFERENCES [IR].[IndieningTypeVersie] ([IndieningTypeVersieID])
);

