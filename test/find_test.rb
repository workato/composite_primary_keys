require 'abstract_unit'
require 'fixtures/reference_type'
require 'fixtures/reference_code'

# Testing the find action on composite ActiveRecords with two primary keys
class FindTest < Test::Unit::TestCase
  fixtures :reference_types, :reference_codes
  
  @@classes = {
    :single => {
      :class => ReferenceType,
      :primary_keys => [:reference_type_id],
    },
    :dual   => { 
      :class => ReferenceCode,
      :primary_keys => [:reference_type_id, :reference_code],
    }
  }
  
  def test_find_first
    testing_with do
      obj = @klass.find_first
      assert obj
      assert_equal @klass, obj.class
    end
  end
  
  def test_ids
    testing_with do
      assert_equal @first.id, @first.ids if composite?
    end
  end
  
  def test_find
    testing_with do
      found = @klass.find(*first_id) # e.g. find(1,1) or find 1,1
      assert found
      assert_equal @klass, found.class
      assert_equal found, @klass.find(found.id)
      assert_equal found, @klass.find(found.to_param)
    end
  end
  
  def test_to_param
    testing_with do
      assert_equal first_id_str, @first.to_param.to_s
    end
  end
  
  def things_to_look_at
    testing_with do
      assert_equal found, @klass.find(found.id.to_s) # fails for 2+ keys
    end
  end
  
end