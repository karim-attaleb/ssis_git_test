CREATE TABLE [Verkennota].[SocialeFunctieToekomstig] (
    [SocialeFunctieToekomstigID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                    INT            NOT NULL,
    [SocialeFunctieToekomstigTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]                   NVARCHAR (MAX) NULL,
    [SoftDeleted]                    BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                     ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([SocialeFunctieToekomstigID] ASC),
    CONSTRAINT [FK_SocialeFunctieToekomstig_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_SocialeFunctieToekomstig_SocialeFunctieToekomstigType] FOREIGN KEY ([SocialeFunctieToekomstigTypeID]) REFERENCES [Verkennota].[SocialeFunctieToekomstigType] ([SocialeFunctieToekomstigTypeID])
);

