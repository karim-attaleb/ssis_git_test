CREATE TABLE [FF].[VisVerlof] (
    [IndieningID]         INT              NOT NULL,
    [VisVerlofTypeID]     NVARCHAR (15)    NULL,
    [VisVerlofNummer]     NVARCHAR (15)    NULL,
    [VisVerlofEigen]      BIT              DEFAULT ((1)) NULL,
    [ReglementTaal]       NVARCHAR (2)     NULL,
    [InfoBrochure]        BIT              DEFAULT ((1)) NULL,
    [BetalingTypeID]      NVARCHAR (15)    NULL,
    [Bedrag]              DECIMAL (10, 2)  NULL,
    [OorsprongTypeID]     NVARCHAR (15)    NULL,
    [BPostDocumentNummer] NVARCHAR (50)    NULL,
    [BPostRCCode]         NVARCHAR (15)    NULL,
    [BPostPostCode]       NVARCHAR (15)    NULL,
    [BPostGemeente]       NVARCHAR (50)    NULL,
    [AuthenticatieID]     UNIQUEIDENTIFIER NULL,
    [SoftDeleted]         BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION       NOT NULL,
    CONSTRAINT [PK_VisVerlof] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_VisVerlof_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_VisVerlof_VisVerlofType] FOREIGN KEY ([VisVerlofTypeID]) REFERENCES [FF].[VisVerlofType] ([VisVerlofTypeID])
);

