# docker-php-tools
Docker image containing common tools used in php development

Based in [docker images for composer](https://github.com/RobLoach/docker-composer), PHP7 and PHP5 versions.

## Integrated tools

### Package manager

* Composer

### Tasks runner

* Phing

### Testing

* PHPUnit + DBUnit
* Codeception

### Static Code Analysis

* PHP Copy-Paste Detector
* PHP LOC
* PHP Mess Detector
* PHP CodeSniffer + Symfony2 Code Standard
* PHP Metrics
* Security Checker

### Code fixing

* PHP CS Fixer

### Phar creation

* Box2

## Use

### Installation

Download the Dockerfile you need (PHP7 and PHP5 versions included) and execute:
```bash
docker build . -t php-tools
```
Copy `php-tool-run` file to your PATH.

### Run

`php-tool-run <tool>`

#### Examples:

```bash
php-tool-run composer update
```

```bash
# Run php-cs-fixer in ./src
php-tool-run php-cs-fixer fix src
```

```bash
# Runs composer update and then change the ownerships of vendor
# files to the current user and group (docker will give ownership to root)
php-tool-run composer update --dpt-owner
```

```bash
# Runs composer update and then change the ownerships of vendor
# files to the given user and group (docker will give ownership to root)
php-tool-run composer update --dpt-owner --dpt-user myuser --dpt-group mygroup
```

```bash
# Runs php-cs-fixer in the given directory
php-tool-run php-cs-fixer --dpt-dir /my/path
```

