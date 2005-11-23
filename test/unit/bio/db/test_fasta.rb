#
# test/unit/bio/db/test_fasta.rb - Unit test for Bio::FastaFormat
#
#   Copyright (C) 2005 Mitsuteru Nakao <n@bioruby.org>
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
#
#  $Id: test_fasta.rb,v 1.2 2005/11/23 11:21:15 nakao Exp $
#

require 'pathname'
libpath = Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 4, 'lib')).cleanpath.to_s
$:.unshift(libpath) unless $:.include?(libpath)

require 'test/unit'
require 'bio/db/fasta'

module Bio
  class TestFastaFormatConst < Test::Unit::TestCase

    def test_delimiter
      assert_equal("\n>", Bio::FastaFormat::DELIMITER)
      assert_equal("\n>", Bio::FastaFormat::RS)
    end

  end # class TestFastaFormatConst


  class TestFastaFormat < Test::Unit::TestCase

    def setup
      text =<<END
>sce:YBR160W  CDC28, SRM5; cyclin-dependent protein kinase catalytic subunit [EC:2.7.1.-] [SP:CC28_YEAST]
MSGELANYKRLEKVGEGTYGVVYKALDLRPGQGQRVVALKKIRLESEDEG
VPSTAIREISLLKELKDDNIVRLYDIVHSDAHKLYLVFEFLDLDLKRYME
GIPKDQPLGADIVKKFMMQLCKGIAYCHSHRILHRDLKPQNLLINKDGNL
KLGDFGLARAFGVPLRAYTHEIVTLWYRAPEVLLGGKQYSTGVDTWSIGC
IFAEMCNRKPIFSGDSEIDQIFKIFRVLGTPNEAIWPDIVYLPDFKPSFP
QWRRKDLSQVVPSLDPRGIDLLDKLLAYDPINRISARRAAIHPYFQES
>sce:YBR274W  CHK1; probable serine/threonine-protein kinase [EC:2.7.1.-] [SP:KB9S_YEAST]
MSLSQVSPLPHIKDVVLGDTVGQGAFACVKNAHLQMDPSIILAVKFIHVP
TCKKMGLSDKDITKEVVLQSKCSKHPNVLRLIDCNVSKEYMWIILEMADG
GDLFDKIEPDVGVDSDVAQFYFQQLVSAINYLHVECGVAHRDIKPENILL
DKNGNLKLADFGLASQFRRKDGTLRVSMDQRGSPPYMAPEVLYSEEGYYA
DRTDIWSIGILLFVLLTGQTPWELPSLENEDFVFFIENDGNLNWGPWSKI
EFTHLNLLRKILQPDPNKRVTLKALKLHPWVLRRASFSGDDGLCNDPELL
AKKLFSHLKVSLSNENYLKFTQDTNSNNRYISTQPIGNELAELEHDSMHF
QTVSNTQRAFTSYDSNTNYNSGTGMTQEAKWTQFISYDIAALQFHSDEND
CNELVKRHLQFNPNKLTKFYTLQPMDVLLPILEKALNLSQIRVKPDLFAN
FERLCELLGYDNVFPLIINIKTKSNGGYQLCGSISIIKIEEELKSVGFER
KTGDPLEWRRLFKKISTICRDIILIPN
END
      @obj = Bio::FastaFormat.new(text)
    end

    def test_entry
      data = ">sce:YBR160W  CDC28, SRM5; cyclin-dependent protein kinase catalytic subunit [EC:2.7.1.-] [SP:CC28_YEAST]\nMSGELANYKRLEKVGEGTYGVVYKALDLRPGQGQRVVALKKIRLESEDEG\nVPSTAIREISLLKELKDDNIVRLYDIVHSDAHKLYLVFEFLDLDLKRYME\nGIPKDQPLGADIVKKFMMQLCKGIAYCHSHRILHRDLKPQNLLINKDGNL\nKLGDFGLARAFGVPLRAYTHEIVTLWYRAPEVLLGGKQYSTGVDTWSIGC\nIFAEMCNRKPIFSGDSEIDQIFKIFRVLGTPNEAIWPDIVYLPDFKPSFP\nQWRRKDLSQVVPSLDPRGIDLLDKLLAYDPINRISARRAAIHPYFQES\n"
      assert_equal(data, @obj.entry)
    end

    def test_entry_id
      assert_equal('sce:YBR160W', @obj.entry_id)
    end

    def test_definition
      data = "sce:YBR160W  CDC28, SRM5; cyclin-dependent protein kinase catalytic subunit [EC:2.7.1.-] [SP:CC28_YEAST]"
      assert_equal(data, @obj.definition)
    end

    def test_data
      data = "\nMSGELANYKRLEKVGEGTYGVVYKALDLRPGQGQRVVALKKIRLESEDEG\nVPSTAIREISLLKELKDDNIVRLYDIVHSDAHKLYLVFEFLDLDLKRYME\nGIPKDQPLGADIVKKFMMQLCKGIAYCHSHRILHRDLKPQNLLINKDGNL\nKLGDFGLARAFGVPLRAYTHEIVTLWYRAPEVLLGGKQYSTGVDTWSIGC\nIFAEMCNRKPIFSGDSEIDQIFKIFRVLGTPNEAIWPDIVYLPDFKPSFP\nQWRRKDLSQVVPSLDPRGIDLLDKLLAYDPINRISARRAAIHPYFQES\n"
      assert_equal(data, @obj.data)
    end

    def test_seq
      seq = 'MSGELANYKRLEKVGEGTYGVVYKALDLRPGQGQRVVALKKIRLESEDEGVPSTAIREISLLKELKDDNIVRLYDIVHSDAHKLYLVFEFLDLDLKRYMEGIPKDQPLGADIVKKFMMQLCKGIAYCHSHRILHRDLKPQNLLINKDGNLKLGDFGLARAFGVPLRAYTHEIVTLWYRAPEVLLGGKQYSTGVDTWSIGCIFAEMCNRKPIFSGDSEIDQIFKIFRVLGTPNEAIWPDIVYLPDFKPSFPQWRRKDLSQVVPSLDPRGIDLLDKLLAYDPINRISARRAAIHPYFQES'
      assert_equal(seq, @obj.seq)
    end

    def test_length
      assert_equal(298, @obj.length)
    end

    def test_naseq
      seq = 'msgelanykrlekvgegtygvvykaldlrpgqgqrvvalkkirlesedegvpstaireisllkelkddnivrlydivhsdahklylvfefldldlkrymegipkdqplgadivkkfmmqlckgiaychshrilhrdlkpqnllinkdgnlklgdfglarafgvplraytheivtlwyrapevllggkqystgvdtwsigcifaemcnrkpifsgdseidqifkifrvlgtpneaiwpdivylpdfkpsfpqwrrkdlsqvvpsldprgidlldkllaydpinrisarraaihpyfqes'
      assert_equal(seq, @obj.naseq)
    end

    def test_nalen
      assert_equal(298, @obj.nalen)
    end

    def test_aaseq
      seq = "MSGELANYKRLEKVGEGTYGVVYKALDLRPGQGQRVVALKKIRLESEDEGVPSTAIREISLLKELKDDNIVRLYDIVHSDAHKLYLVFEFLDLDLKRYMEGIPKDQPLGADIVKKFMMQLCKGIAYCHSHRILHRDLKPQNLLINKDGNLKLGDFGLARAFGVPLRAYTHEIVTLWYRAPEVLLGGKQYSTGVDTWSIGCIFAEMCNRKPIFSGDSEIDQIFKIFRVLGTPNEAIWPDIVYLPDFKPSFPQWRRKDLSQVVPSLDPRGIDLLDKLLAYDPINRISARRAAIHPYFQES"
      assert_equal(seq, @obj.aaseq)
    end

    def test_aalen
      assert_equal(298, @obj.aalen)
    end

    def test_identifiers
      assert_equal('', @obj.identifiers)
    end

    def test_gi
      assert_equal('', @obj.gi)
    end

    def test_accession
      assert_equal('', @obj.accession)
    end

    def test_accessions
      assert_equal('', @obj.accessions)
    end

    def test_acc_version
      assert_equal('', @obj.acc_version)
    end

    def test_locus
      assert_equal('', @obj.locus)
    end

  end # class TestFastaFormat


  class TestFastaNumericFormat < Test::Unit::TestCase

    def setup
      text =<<END
>CRA3575282.F 
24 15 23 29 20 13 20 21 21 23 22 25 13 22 17 15 25 27 32 26  
32 29 29 25
END
      @obj = Bio::FastaNumericFormat.new(text)
    end

    def test_entry
      assert_equal(">CRA3575282.F\n24 15 23 29 20 13 20 21 21 23 22 25 13 22 17 15 25 27 32 26  \n32 29 29 25\n", @obj.entry)
    end

    def test_entry_id
      assert_equal('CRA3575282.F', @obj.entry_id) 
    end

    def test_definition
      assert_equal('CRA3575282.F', @obj.definition)
    end

    def test_data
      data = [24, 15, 23, 29, 20, 13, 20, 21, 21, 23, 22, 25, 13, 22, 17, 15, 25, 27, 32, 26, 32, 29, 29, 25]
      assert_equal(data, @obj.data)
    end

    def test_length
      assert_equal(24, @obj.length)
    end

    def test_each
      assert(@obj.each {|x| })
    end

    def test_arg
      assert(@obj[0], '')
      assert(@obj[-1], '')
    end


  end # class TestFastaFormatNumeric


  class TestFastaDefinition < Test::Unit::TestCase

    def setup
    end

    def test_defline
    end
  end # class TestFastaDefinition

end
