# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-10-05 10:31
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('jobapp', '0010_auto_20171002_0157'),
    ]

    operations = [
        migrations.AddField(
            model_name='customscript',
            name='script_args',
            field=models.CharField(blank=True, max_length=80, null=True),
        ),
    ]
