# Wordpress Image Migration

This is only for my company's specific situation.

## Strategy

- Step 0. Download spread sheet as CSV missing_images.csv https://docs.google.com/a/odigo.jp/spreadsheets/d/1Bwv-tMsc1iT3uD0ux8oyw2Vb069Of7sNU8JdvFtHQKE/edit?usp=sharing
- Step 1. Process CSV and download image files with keeping directly path
- Step 2. Copy all downloaded images to server
- Step 3. Update timestamp
- Step 4. Go to admin dashboard and "Add from Server" all files with "File Time" mode

```
-- step 1 (local) --
$ ruby download.rb

-- step 2 (local) --
$ scp -r ./ ubuntu@<address>:~/blog_image_migration

-- step 3 (remote) --
$ ssh ubuntu@<address>
$ cd blog_image_migration
$ touch -t 201602010000 2016/02/*
$ touch -t 201603010000 2016/03/*
$ touch -t 201501010000 2015/01/*
$ touch -t 201511010000 2015/11/*
$ touch -t 201506010000 2015/06/*
$ # and more if there's other directories
```
