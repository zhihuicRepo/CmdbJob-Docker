from __future__ import unicode_literals

from django.db import models

# Create your models here.


class DynamicGroup(models.Model):
	GroupName = models.CharField(max_length=128,unique=True)
	GroupMembers = models.TextField()


class SaltGroup(models.Model):
	GroupName = models.CharField(max_length=128,unique=True)
	GroupExpr = models.TextField()


class action_audit(models.Model):
	jid = models.CharField(max_length=255,unique=True)
	user = models.CharField(max_length=50)


class ExecUser(models.Model):
	user = models.CharField(max_length=50,unique=True)


class CustomScript(models.Model):
	script_name = models.CharField(max_length=80,unique=True)
	author = models.CharField(max_length=50)
	editor = models.CharField(max_length=50)
	script_code = models.TextField()
	script_args = models.CharField(max_length=80,null=True,blank=True)
	script_type = models.CharField(max_length=15)
	comment = models.TextField(null=True,blank=True) 

	def __unicode__(self):
		return self.script_name








	