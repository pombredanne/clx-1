# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-3.2.14.ebuild,v 1.1 2013/08/17 10:30:43 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activesupport.gemspec"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem versionator

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
SRC_URI="https://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "
	>=dev-ruby/multi_json-1.0
	>=dev-ruby/i18n-0.6.4:0.6
	!!<dev-ruby/activesupport-3.0.11-r1:3.0"

# memcache-client, nokogiri, and builder are not strictly
# needed, but there are tests using this code.
ruby_add_bdepend "test? (
	dev-ruby/test-unit:2
	>=dev-ruby/memcache-client-1.5.8
	dev-ruby/nokogiri
	>=dev-ruby/builder-3.0.3:3
	>=dev-ruby/tzinfo-0.3.37
	)"

# libxml is not strictly needed, there are tests using this code. jruby
# uses a different xml implementation.
USE_RUBY=${USE_RUBY/jruby/} ruby_add_bdepend "test? ( >=dev-ruby/libxml-2.0.0 )"

all_ruby_prepare() {
	# Set test environment to our hand.
#	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"

	# Make sure we use the test-unit gem since ruby18 does not provide
	# all the test-unit features needed.
	sed -i -e '1igem "test-unit"' test/abstract_unit.rb || die

	# Ignore failing tests on jruby in the interest of a security update
	sed -i -e '/test_not_allowed_to_expand_parameter_entities_to_files/,/^    end/ s:^:#:' \
		-e '/test_exception_thrown_on_expansion_attack/,/^    end/ s:^:#:' \
		test/xml_mini/jdom_engine_test.rb || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*ruby18)
			# Skip failing ruby18 tests related to JSON serialization
			rm test/message_encryptor_test.rb test/message_verifier_test.rb || die
			;;
	esac
}
